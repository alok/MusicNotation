import Lean

/-!
# MusicNotation.Basic

Basic definitions for a music notation system.

This module defines the core data structures needed to represent musical notation
including notes, pitches, durations, measures, and staves.
-/

/-- Represents a musical note name without octave or accidental -/
inductive NoteName where
  | C : NoteName
  | D : NoteName
  | E : NoteName
  | F : NoteName
  | G : NoteName
  | A : NoteName
  | B : NoteName
deriving BEq, Repr, Inhabited

/-- Represents a musical accidental -/
inductive Accidental where
  | natural : Accidental
  | sharp : Accidental
  | flat : Accidental
  | doubleSharp : Accidental
  | doubleFlat : Accidental
deriving BEq, Repr, Inhabited

/-- Represents a pitch (note name + accidental + octave) -/
structure Pitch where
  name : NoteName
  accidental : Accidental := .natural
  octave : Nat := 4  -- Middle C is C4
deriving BEq, Repr, Inhabited

/-- Represents a note duration -/
inductive Duration where
  | whole : Duration
  | half : Duration
  | quarter : Duration
  | eighth : Duration
  | sixteenth : Duration
  | thirtySecond : Duration
  | dotted : Duration → Duration  -- Dotted version of a duration
  | triplet : Duration → Duration -- Triplet version of a duration
deriving BEq, Repr, Inhabited

/-- Represents a musical rest -/
structure Rest where
  duration : Duration
deriving BEq, Repr, Inhabited

/-- Represents a musical note with pitch and duration -/
structure Note where
  pitch : Pitch
  duration : Duration
deriving BEq, Repr, Inhabited

/-- Represents a musical element which can be a note or a rest -/
inductive MusicalElement where
  | note : Note → MusicalElement
  | rest : Rest → MusicalElement
deriving BEq, Repr, Inhabited

/-- Represents a time signature -/
structure TimeSignature where
  beats : Nat
  beatValue : Nat
deriving BEq, Repr, Inhabited

/-- Represents a clef type -/
inductive Clef where
  | treble : Clef
  | bass : Clef
  | alto : Clef
  | tenor : Clef
deriving BEq, Repr, Inhabited

/-- Represents a key signature with number of sharps or flats -/
structure KeySignature where
  sharps : Int -- positive for sharps, negative for flats
deriving BEq, Repr, Inhabited

/-- Represents a measure containing musical elements -/
structure Measure where
  elements : List MusicalElement
  timeSignature : TimeSignature
deriving Repr, Inhabited

/-- Represents a musical staff with clef, key signature, and measures -/
structure Staff where
  clef : Clef
  keySignature : KeySignature
  measures : List Measure
deriving Repr, Inhabited

/-- Represents a complete musical score with multiple staves -/
structure Score where
  title : String := ""
  composer : String := ""
  staves : List Staff
deriving Repr, Inhabited

/-! ## Musical Element Creation Functions -/

/-- Create a note with given parameters -/
def makeNote (name : NoteName) (acc : Accidental := .natural)
    (octave : Nat := 4) (dur : Duration := .quarter) : MusicalElement :=
  .note { pitch := { name := name, accidental := acc, octave := octave }, duration := dur }

/-- Create a rest with given duration -/
def makeRest (dur : Duration := .quarter) : MusicalElement :=
  .rest { duration := dur }

/-! ## Common Time Signatures -/

/-- 4/4 time -/
def commonTime : TimeSignature := { beats := 4, beatValue := 4 }

/-- 3/4 time -/
def waltzTime : TimeSignature := { beats := 3, beatValue := 4 }

/-- 6/8 time -/
def compoundTime : TimeSignature := { beats := 6, beatValue := 8 }

/-! ## Common Key Signatures -/

/-- C major / A minor (no sharps or flats) -/
def cMajor : KeySignature := { sharps := 0 }

/-- G major / E minor (1 sharp) -/
def gMajor : KeySignature := { sharps := 1 }

/-- F major / D minor (1 flat) -/
def fMajor : KeySignature := { sharps := -1 }
