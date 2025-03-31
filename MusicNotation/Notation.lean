import MusicNotation.Basic
import Lean

/-!
# MusicNotation.Notation

This module provides the implementation of Unicode-based staff notation.
-/

namespace MusicNotation

/-- Create a musical note -/
def note (name : NoteName) (acc : Accidental := .natural)
    (octave : Nat := 4) (dur : Duration := .quarter) : MusicalElement :=
  makeNote name acc octave dur

/-- Create a C note with given parameters -/
def c (octave : Nat := 4) (dur : Duration := .quarter) (acc : Accidental := .natural) : MusicalElement :=
  note .C acc octave dur

/-- Create a D note with given parameters -/
def d (octave : Nat := 4) (dur : Duration := .quarter) (acc : Accidental := .natural) : MusicalElement :=
  note .D acc octave dur

/-- Create an E note with given parameters -/
def e (octave : Nat := 4) (dur : Duration := .quarter) (acc : Accidental := .natural) : MusicalElement :=
  note .E acc octave dur

/-- Create an F note with given parameters -/
def f (octave : Nat := 4) (dur : Duration := .quarter) (acc : Accidental := .natural) : MusicalElement :=
  note .F acc octave dur

/-- Create a G note with given parameters -/
def g (octave : Nat := 4) (dur : Duration := .quarter) (acc : Accidental := .natural) : MusicalElement :=
  note .G acc octave dur

/-- Create an A note with given parameters -/
def a (octave : Nat := 4) (dur : Duration := .quarter) (acc : Accidental := .natural) : MusicalElement :=
  note .A acc octave dur

/-- Create a B note with given parameters -/
def b (octave : Nat := 4) (dur : Duration := .quarter) (acc : Accidental := .natural) : MusicalElement :=
  note .B acc octave dur

/-- Create a rest with given duration -/
def rest (dur : Duration := .quarter) : MusicalElement :=
  makeRest dur

/-- Helper to create a C major scale -/
def cMajorScale (octave : Nat := 4) (dur : Duration := .quarter) : List MusicalElement :=
  [c octave dur, d octave dur, e octave dur, f octave dur,
   g octave dur, a octave dur, b octave dur, c (octave+1) dur]

/-- F# note -/
def fSharp (octave : Nat := 4) (dur : Duration := .quarter) : MusicalElement :=
  f octave dur .sharp

/-- G major scale -/
def gMajorScale (octave : Nat := 4) (dur : Duration := .quarter) : List MusicalElement :=
  [g octave dur, a octave dur, b octave dur, c (octave+1) dur,
   d (octave+1) dur, e (octave+1) dur, fSharp (octave+1) dur, g (octave+1) dur]

/-- Bb note -/
def bFlat (octave : Nat := 4) (dur : Duration := .quarter) : MusicalElement :=
  b octave dur .flat

/-- F major scale -/  
def fMajorScale (octave : Nat := 4) (dur : Duration := .quarter) : List MusicalElement :=
  [f octave dur, g octave dur, a octave dur, bFlat octave dur,
   c (octave+1) dur, d (octave+1) dur, e (octave+1) dur, f (octave+1) dur]

/-- Create string for horizontal line of staff -/
def staffHorizontalLine (width : Nat) : String :=
  String.mk (List.replicate width '─')

/-- Create a top line for a staff -/
def createStaffTopLine (width : Nat) : StaffLine :=
  { elements := ["┌" ++ staffHorizontalLine width ++ "┐"] }

/-- Create a bottom line for a staff -/
def createStaffBottomLine (width : Nat) : StaffLine :=
  { elements := ["└" ++ staffHorizontalLine width ++ "┘"] }

/-- Convert a musical element to a unicode string for staff notation -/
def musicalElementToStaffString : MusicalElement → String
| .note n => 
  let pitchStr := noteNameToString n.pitch.name ++ 
                 (if n.pitch.accidental != .natural then accidentalToString n.pitch.accidental else "") ++ 
                 toString n.pitch.octave
  durationToString n.duration ++ pitchStr
| .rest r => "𝄽" ++ durationToString r.duration

/-- Create a middle line for a staff with musical elements -/
def createStaffMiddleLine (elements : List MusicalElement) : StaffLine :=
  let elementStrings := elements.map musicalElementToStaffString
  let barStart := "│"
  let barEnd := "│"
  let content := String.intercalate " " elementStrings
  { elements := [barStart ++ content ++ barEnd] }

/-- Create a complete staff with given elements -/
def createStaff (clef : Clef) (elements : List MusicalElement) : Staff :=
  let middleLine := createStaffMiddleLine elements
  let width := (String.length (middleLine.elements.head!)) - 2 -- Subtract 2 for the vertical bars
  {
    clef := clef,
    topLine := createStaffTopLine width,
    middleLines := [middleLine],
    bottomLine := createStaffBottomLine width
  }

/-- Format a staff as a string for display -/
def formatStaff (staff : Staff) : String :=
  let clefStr := clefToString staff.clef
  let topLineStr := staff.topLine.elements.head!
  let middleLinesStr := String.intercalate "\n" (staff.middleLines.map (·.elements.head!))
  let bottomLineStr := staff.bottomLine.elements.head!
  
  -- Insert clef at the beginning of the middle line
  let middleLinesWithClef := "│" ++ clefStr ++ middleLinesStr.drop 1
  
  topLineStr ++ "\n" ++ middleLinesWithClef ++ "\n" ++ bottomLineStr

end MusicNotation