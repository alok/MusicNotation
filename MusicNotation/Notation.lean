import MusicNotation.Basic
import Lean

/-!
# MusicNotation.Notation

This module defines convenient constructors and functions for music notation,
providing a more direct programmatic interface than raw constructors.
-/

namespace MusicNotation

/-- Create a note with common parameters -/
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

/-- Create a measure with given elements and time signature -/
def measure (elements : List MusicalElement) (timeSignature : TimeSignature := commonTime) : Measure :=
  { elements := elements, timeSignature := timeSignature }

/-- Create a staff with the given properties -/
def staff (clef : Clef) (keySignature : KeySignature) (measures : List Measure) : Staff :=
  { clef := clef, keySignature := keySignature, measures := measures }

/-- Create a score with given properties -/
def score (title : String := "") (composer : String := "") (staves : List Staff) : Score :=
  { title := title, composer := composer, staves := staves }

/-- Helper to create a sequence of same notes with same parameters -/
def repeatNote (element : MusicalElement) (count : Nat) : List MusicalElement :=
  List.replicate count element

/-- Helper to create a C major scale starting at the given octave -/
def cMajorScale (octave : Nat := 4) (dur : Duration := .quarter) : List MusicalElement :=
  [c octave dur, d octave dur, e octave dur, f octave dur,
   g octave dur, a octave dur, b octave dur, c (octave+1) dur]

/-- Create F sharp note -/
def fSharp (octave : Nat := 4) (dur : Duration := .quarter) : MusicalElement :=
  f octave dur .sharp

/-- Helper to create a G major scale starting at the given octave -/
def gMajorScale (octave : Nat := 4) (dur : Duration := .quarter) : List MusicalElement :=
  [g octave dur, a octave dur, b octave dur, c (octave+1) dur,
   d (octave+1) dur, e (octave+1) dur, fSharp (octave+1) dur, g (octave+1) dur]

/-- Create B flat note -/
def bFlat (octave : Nat := 4) (dur : Duration := .quarter) : MusicalElement :=
  b octave dur .flat

/-- Helper to create a F major scale starting at the given octave -/
def fMajorScale (octave : Nat := 4) (dur : Duration := .quarter) : List MusicalElement :=
  [f octave dur, g octave dur, a octave dur, bFlat octave dur,
   c (octave+1) dur, d (octave+1) dur, e (octave+1) dur, f (octave+1) dur]

/-- Create a C major chord -/
def cChord (octave : Nat := 4) (dur : Duration := .quarter) : List MusicalElement :=
  [c octave dur, e octave dur, g octave dur]

/-- Create a G major chord -/
def gChord (octave : Nat := 4) (dur : Duration := .quarter) : List MusicalElement :=
  [g octave dur, b octave dur, d (octave+1) dur]

/-- Create a F major chord -/
def fChord (octave : Nat := 4) (dur : Duration := .quarter) : List MusicalElement :=
  [f octave dur, a octave dur, c (octave+1) dur]

end MusicNotation
