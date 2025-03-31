import MusicNotation.Basic
import MusicNotation.Notation

/-!
# MusicNotation.Visualization

This module provides string formatting functions and more complex staff rendering with multiple lines.
-/

namespace MusicNotation

/-- Render multiple staffs as a multi-line string -/
def renderMultipleStaffs (staffs : List Staff) : String :=
  String.intercalate "\n\n" (staffs.map formatStaff)

/-- Create a "prettier" staff with 5 staff lines using Unicode box-drawing characters -/
def createStandardStaff (clef : Clef) (elements : List MusicalElement) : String :=
  let noteStr := String.intercalate " " (elements.map musicalElementToStaffString)
  let width := noteStr.length + 10  -- Add some padding
  let clefStr := clefToString clef
  let staffLine := String.mk (List.replicate width '─')
  
  "┌" ++ staffLine ++ "┐\n" ++
  "│ " ++ clefStr ++ " " ++ noteStr ++ "   │\n" ++
  "└" ++ staffLine ++ "┘"

/-- Creates a C major scale staff with standard notation -/
def cMajorScaleStaff : String :=
  createStandardStaff .treble (cMajorScale 4 .quarter)

/-- Creates a G major scale staff with standard notation -/
def gMajorScaleStaff : String :=
  createStandardStaff .treble (gMajorScale 4 .quarter)

/-- Creates an F major scale staff with standard notation -/
def fMajorScaleStaff : String :=
  createStandardStaff .treble (fMajorScale 4 .quarter)

/-- Creates a staff with Twinkle Twinkle Little Star -/
def twinkleTwinkleStaff : String := Id.run do
  let elements := [
    c 4 .quarter, c 4 .quarter, g 4 .quarter, g 4 .quarter,
    a 4 .quarter, a 4 .quarter, g 4 .half,
    f 4 .quarter, f 4 .quarter, e 4 .quarter, e 4 .quarter,
    d 4 .quarter, d 4 .quarter, c 4 .half
  ]
  
  createStandardStaff .treble elements

/-- Create a staff showing different durations -/
def durationExampleStaff : String := Id.run do
  let elements := [
    c 4 .whole,
    d 4 .half,
    e 4 .quarter,
    f 4 .eighth,
    g 4 .sixteenth,
    rest .quarter
  ]
  
  createStandardStaff .treble elements

/-- Create a staff showing different accidentals -/
def accidentalExampleStaff : String := Id.run do
  let elements := [
    c 4 .quarter,
    c 4 .quarter .sharp,
    d 4 .quarter .flat,
    f 4 .quarter .natural,
    g 4 .quarter .doubleSharp,
    a 4 .quarter .doubleFlat
  ]
  
  createStandardStaff .treble elements

/-- Create a staff showing different clefs -/
def clefExampleStaff : String := Id.run do
  let elements := [c 4 .quarter, d 4 .quarter, e 4 .quarter]
  let trebleStaff := createStandardStaff .treble elements
  let bassStaff := createStandardStaff .bass elements
  let altoStaff := createStandardStaff .alto elements
  
  trebleStaff ++ "\n\n" ++ bassStaff ++ "\n\n" ++ altoStaff

end MusicNotation

-- Examples that can be evaluated
#eval MusicNotation.cMajorScaleStaff
#eval MusicNotation.gMajorScaleStaff
#eval MusicNotation.fMajorScaleStaff
#eval MusicNotation.twinkleTwinkleStaff
#eval MusicNotation.durationExampleStaff
#eval MusicNotation.accidentalExampleStaff
#eval MusicNotation.clefExampleStaff