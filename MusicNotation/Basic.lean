import Lean

/-!
# MusicNotation.Basic

Basic definitions for a music notation system using Unicode characters.
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

/-- Represents a note duration -/
inductive Duration where
  | whole : Duration        -- 𝅝
  | half : Duration         -- 𝅗𝅥
  | quarter : Duration      -- 𝅘𝅥
  | eighth : Duration       -- 𝅘𝅥𝅮
  | sixteenth : Duration    -- 𝅘𝅥𝅯
  | thirtySecond : Duration -- 𝅘𝅥𝅰
  | dotted : Duration → Duration  -- Adds a dot
  | triplet : Duration → Duration -- Triplet notation
deriving BEq, Repr, Inhabited

/-- Represents a clef type -/
inductive Clef where
  | treble : Clef  -- 𝄞
  | bass : Clef    -- 𝄢
  | alto : Clef    -- 𝄡
  | tenor : Clef   -- 𝄡 (positioned differently)
deriving BEq, Repr, Inhabited

/-- Pitch with note name, accidental, and octave -/
structure Pitch where
  name : NoteName
  accidental : Accidental := .natural
  octave : Nat := 4  -- Middle C is C4
deriving BEq, Repr, Inhabited

/-- Musical note with pitch and duration -/
structure Note where
  pitch : Pitch
  duration : Duration
deriving BEq, Repr, Inhabited

/-- Musical rest with duration -/
structure Rest where
  duration : Duration
deriving BEq, Repr, Inhabited

/-- A musical element (note or rest) -/
inductive MusicalElement where
  | note : Note → MusicalElement
  | rest : Rest → MusicalElement
deriving BEq, Repr, Inhabited

/-- A staff line in Unicode notation -/
structure StaffLine where
  elements : List String  -- Unicode representations
deriving Repr, Inhabited

/-- A complete staff with multiple lines -/
structure Staff where
  clef : Clef
  topLine : StaffLine    -- Top line of staff
  middleLines : List StaffLine  -- Note lines
  bottomLine : StaffLine -- Bottom line of staff
deriving Repr, Inhabited

/-- Helper functions for converting music elements to Unicode -/

def noteNameToString : NoteName → String
| .C => "C"
| .D => "D"
| .E => "E"
| .F => "F"
| .G => "G"
| .A => "A"
| .B => "B"

def accidentalToString : Accidental → String
| .natural => "♮"
| .sharp => "♯"
| .flat => "♭"
| .doubleSharp => "𝄪"
| .doubleFlat => "𝄫"

def durationToString : Duration → String
| .whole => "𝅝"
| .half => "𝅗𝅥"
| .quarter => "𝅘𝅥"
| .eighth => "𝅘𝅥𝅮"
| .sixteenth => "𝅘𝅥𝅯"
| .thirtySecond => "𝅘𝅥𝅰"
| .dotted d => durationToString d ++ "."
| .triplet d => durationToString d ++ "³"

def clefToString : Clef → String
| .treble => "𝄞"
| .bass => "𝄢" 
| .alto => "𝄡"
| .tenor => "𝄡"

/-- Create a note with given parameters -/
def makeNote (name : NoteName) (acc : Accidental := .natural)
    (octave : Nat := 4) (dur : Duration := .quarter) : MusicalElement :=
  .note { pitch := { name := name, accidental := acc, octave := octave }, duration := dur }

/-- Create a rest with given duration -/
def makeRest (dur : Duration := .quarter) : MusicalElement :=
  .rest { duration := dur }

#eval "Music notation example: " ++ noteNameToString .C ++ accidentalToString .sharp ++ "4" ++ durationToString .quarter