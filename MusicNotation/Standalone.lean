import Lean

/-!
# MusicNotation.Standalone

This module demonstrates Unicode-based music notation without dependencies.
All examples use Unicode characters to display musical notation directly.
-/

/-- Represents a musical note name -/
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
  | whole : Duration
  | half : Duration
  | quarter : Duration
  | eighth : Duration
  | sixteenth : Duration
  | thirtySecond : Duration
  | dotted : Duration → Duration
  | triplet : Duration → Duration
deriving BEq, Repr, Inhabited

/-- Note name to string conversion -/
def noteNameToUnicode : NoteName → String
| .C => "C"
| .D => "D"
| .E => "E"
| .F => "F"
| .G => "G"
| .A => "A"
| .B => "B"

/-- Accidental to Unicode conversion -/
def accidentalToUnicode : Accidental → String
| .natural => "♮"
| .sharp => "♯"
| .flat => "♭"
| .doubleSharp => "𝄪"
| .doubleFlat => "𝄫"

/-- Duration to Unicode conversion -/
def durationToUnicode : Duration → String
| .whole => "𝅝"
| .half => "𝅗𝅥"
| .quarter => "𝅘𝅥"
| .eighth => "𝅘𝅥𝅮"
| .sixteenth => "𝅘𝅥𝅯"
| .thirtySecond => "𝅘𝅥𝅰"
| .dotted d => durationToUnicode d ++ "."
| .triplet d => durationToUnicode d ++ "³"

/-- Clef to Unicode conversion -/
def clefToUnicode : String
| "treble" => "𝄞"
| "bass" => "𝄢"
| "alto" => "𝄡"
| "tenor" => "𝄡"
| _ => "?"

/-- Create a string with a character repeated n times -/
def repeatChar (char : String) (n : Nat) : String := Id.run do
  let mut result := ""
  for _ in [:n] do
    result := result ++ char
  return result

/-- C major scale as a Unicode staff -/
def cMajorScaleUnicode : String :=
  "┌─────────────────────────────────────┐\n" ++
  "│𝄞|─𝅘𝅥C─|─𝅘𝅥D─|─𝅘𝅥E─|─𝅘𝅥F─|─𝅘𝅥G─|─𝅘𝅥A─|─𝅘𝅥B─|─𝅘𝅥C─|│\n" ++
  "└─────────────────────────────────────┘"

/-- G major scale as a Unicode staff -/
def gMajorScaleUnicode : String :=
  "┌─────────────────────────────────────────────┐\n" ++
  "│𝄞|─𝅘𝅥G─|─𝅘𝅥A─|─𝅘𝅥B─|─𝅘𝅥C─|─𝅘𝅥D─|─𝅘𝅥E─|─𝅘𝅥F♯─|─𝅘𝅥G─|│\n" ++
  "└─────────────────────────────────────────────┘"

/-- F major scale as a Unicode staff -/
def fMajorScaleUnicode : String :=
  "┌─────────────────────────────────────────────┐\n" ++
  "│𝄞|─𝅘𝅥F─|─𝅘𝅥G─|─𝅘𝅥A─|─𝅘𝅥B♭─|─𝅘𝅥C─|─𝅘𝅥D─|─𝅘𝅥E─|─𝅘𝅥F─|│\n" ++
  "└─────────────────────────────────────────────┘"

/-- C major chord as a Unicode staff -/
def cChordUnicode : String :=
  "┌──────────────┐\n" ++
  "│𝄞|─𝅘𝅥C𝅘𝅥E𝅘𝅥G─|│\n" ++
  "└──────────────┘"

/-- Twinkle Twinkle Little Star as a Unicode staff -/
def twinkleTwinkleUnicode : String :=
  "┌──────────────────────────────────────────┐\n" ++
  "│𝄞|─𝅘𝅥C─𝅘𝅥C─𝅘𝅥G─𝅘𝅥G─|─𝅘𝅥A─𝅘𝅥A─𝅗𝅥G─|─𝅘𝅥F─𝅘𝅥F─𝅘𝅥E─𝅘𝅥E─|─𝅘𝅥D─𝅘𝅥D─𝅗𝅥C─|│\n" ++
  "└──────────────────────────────────────────┘"

/-- Example showing different durations -/
def durationExampleUnicode : String :=
  "┌──────────────────────────────────────────┐\n" ++
  "│𝄞|─𝅝C─|─𝅗𝅥D─|─𝅘𝅥E─|─𝅘𝅥𝅮F─|─𝅘𝅥𝅯G─|─𝄽─|│\n" ++
  "└──────────────────────────────────────────┘"

/-- Example showing different accidentals -/
def accidentalExampleUnicode : String :=
  "┌──────────────────────────────────────────┐\n" ++
  "│𝄞|─𝅘𝅥C─|─𝅘𝅥C♯─|─𝅘𝅥D♭─|─𝅘𝅥F♮─|─𝅘𝅥G𝄪─|─𝅘𝅥A𝄫─|│\n" ++
  "└──────────────────────────────────────────┘"

/-- Example showing different clefs -/
def clefExampleUnicode : String :=
  "┌──────────────────────────┐\n" ++
  "│𝄞|─𝅘𝅥C─|─𝅘𝅥D─|─𝅘𝅥E─|│\n" ++
  "└──────────────────────────┘\n" ++
  "┌──────────────────────────┐\n" ++
  "│𝄢|─𝅘𝅥C─|─𝅘𝅥D─|─𝅘𝅥E─|│\n" ++
  "└──────────────────────────┘\n" ++
  "┌──────────────────────────┐\n" ++
  "│𝄡|─𝅘𝅥C─|─𝅘𝅥D─|─𝅘𝅥E─|│\n" ++
  "└──────────────────────────┘"

/-- A more detailed 5-line staff example with C Major scale -/
def detailedStaffExample : String :=
  "┌─────────────────────────────────────────────┐\n" ++
  "│─────────────────────────────────────────────│\n" ++
  "│─────────────────────────────────────────────│\n" ++
  "│─𝄞───𝅘𝅥C───𝅘𝅥D───𝅘𝅥E───𝅘𝅥F───𝅘𝅥G───𝅘𝅥A───𝅘𝅥B───𝅘𝅥C─│\n" ++
  "│─────────────────────────────────────────────│\n" ++
  "│─────────────────────────────────────────────│\n" ++
  "└─────────────────────────────────────────────┘"

/-- Main function to demonstrate examples -/
def main : IO Unit := do
  IO.println "Unicode Music Notation Examples"
  IO.println "==============================="
  IO.println ""
  IO.println "C major scale:"
  IO.println cMajorScaleUnicode
  IO.println ""
  IO.println "G major scale:"
  IO.println gMajorScaleUnicode
  IO.println ""
  IO.println "F major scale:"
  IO.println fMajorScaleUnicode
  IO.println ""
  IO.println "C major chord:"
  IO.println cChordUnicode
  IO.println ""
  IO.println "Twinkle Twinkle Little Star:"
  IO.println twinkleTwinkleUnicode
  IO.println ""
  IO.println "Different durations:"
  IO.println durationExampleUnicode
  IO.println ""
  IO.println "Different accidentals:"
  IO.println accidentalExampleUnicode
  IO.println ""
  IO.println "Different clefs:"
  IO.println clefExampleUnicode
  IO.println ""
  IO.println "Detailed 5-line staff example:"
  IO.println detailedStaffExample

#eval cMajorScaleUnicode
#eval gMajorScaleUnicode
#eval fMajorScaleUnicode
#eval cChordUnicode
#eval twinkleTwinkleUnicode
#eval durationExampleUnicode
#eval accidentalExampleUnicode
#eval clefExampleUnicode
#eval detailedStaffExample