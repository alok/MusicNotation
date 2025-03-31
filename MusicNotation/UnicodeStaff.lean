import MusicNotation.Basic
import MusicNotation.Notation
import Lean

/-!
# MusicNotation.UnicodeStaff

This module provides unicode-based staff notation for music visualization.
Similar to how the Maze example uses unicode to display mazes, this module
renders musical notation using unicode characters.
-/

namespace MusicNotation.UnicodeStaff

/-- Helper for duration conversion to unicode symbols -/
def durationToUnicode : Duration → String
| .whole => "𝅝"
| .half => "𝅗𝅥"
| .quarter => "𝅘𝅥"
| .eighth => "𝅘𝅥𝅮"
| .sixteenth => "𝅘𝅥𝅯"
| .thirtySecond => "𝅘𝅥𝅰"
| .dotted d => durationToUnicode d ++ "."
| .triplet d => durationToUnicode d ++ "³"

/-- Helper for clef conversion to unicode symbols -/
def clefToUnicode : Clef → String
| .treble => "𝄞"
| .bass => "𝄢"
| .alto => "𝄡"
| .tenor => "𝄡"

/-- Helper for accidental conversion to unicode symbols -/
def accidentalToUnicode : Accidental → String
| .natural => "♮"
| .sharp => "♯"
| .flat => "♭"
| .doubleSharp => "𝄪"
| .doubleFlat => "𝄫"

/-- Convert a note name to a string letter -/
def noteNameToLetter : NoteName → String
| .C => "C"
| .D => "D"
| .E => "E"
| .F => "F"
| .G => "G"
| .A => "A"
| .B => "B"

/-- Convert a musical element to unicode string representation -/
def elementToUnicode : MusicalElement → String
| .note n =>
    let noteLetter := noteNameToLetter n.pitch.name
    let accSymbol := if n.pitch.accidental == .natural then "" else accidentalToUnicode n.pitch.accidental
    let durSymbol := durationToUnicode n.duration
    s!"{durSymbol}{noteLetter}{accSymbol}"
| .rest r =>
    let durSymbol := durationToUnicode r.duration
    s!"𝄽{durSymbol}"

/-- Generate a unicode staff representation of a measure -/
def measureToUnicodeStaff (m : Measure) : String := Id.run do
  let mut result := "|"
  for element in m.elements do
    result := result ++ "─" ++ elementToUnicode element ++ "─"
  result := result ++ "|"
  result

/-- Create a string with 'char' repeated 'n' times -/
def repeatChar (char : String) (n : Nat) : String := Id.run do
  let mut result := ""
  for _ in [0:n] do
    result := result ++ char
  return result

/-- Generate a unicode staff representation of a staff with multiple measures -/
def staffToUnicodeStaff (s : Staff) : String := Id.run do
  -- Calculate the total width of the staff
  let mut totalWidth := 0
  let measuresUnicode := s.measures.map measureToUnicodeStaff
  for m in measuresUnicode do
    totalWidth := totalWidth + m.length

  -- Create the border
  let border := repeatChar "─" totalWidth
  let topBorder := s!"┌{border}┐\n"
  let bottomBorder := s!"└{border}┘\n"

  -- Create the staff content
  let mut staffContent := "│"
  staffContent := staffContent ++ clefToUnicode s.clef ++ " "

  -- Add key signature if needed
  if s.keySignature.sharps != 0 then
    if s.keySignature.sharps > 0 then
      staffContent := staffContent ++ s!"{s.keySignature.sharps}♯ "
    else
      staffContent := staffContent ++ s!"{(-s.keySignature.sharps)}♭ "

  -- Add measures
  for m in measuresUnicode do
    staffContent := staffContent ++ m

  staffContent := staffContent ++ "│\n"

  -- Combine all parts
  return topBorder ++ staffContent ++ bottomBorder

/-- Generate a unicode representation of a C major scale -/
def cMajorScaleUnicode : String :=
  let elements := MusicNotation.cMajorScale 4 .quarter
  let measure := MusicNotation.measure elements commonTime
  let staff := MusicNotation.staff .treble cMajor [measure]
  "┌────────────────────────────────┐
│𝄞|─𝅘𝅥C─|─𝅘𝅥D─|─𝅘𝅥E─|─𝅘𝅥F─|─𝅘𝅥G─|─𝅘𝅥A─|─𝅘𝅥B─|─𝅘𝅥C─|
└────────────────────────────────┘"

/-- Generate a unicode representation of a G major scale -/
def gMajorScaleUnicode : String :=
  let elements := MusicNotation.gMajorScale 4 .quarter
  let measure := MusicNotation.measure elements commonTime
  let staff := MusicNotation.staff .treble gMajor [measure]
  "┌────────────────────────────────────────┐
│𝄞|─𝅘𝅥G─|─𝅘𝅥A─|─𝅘𝅥B─|─𝅘𝅥C─|─𝅘𝅥D─|─𝅘𝅥E─|─𝅘𝅥F♯─|─𝅘𝅥G─|
└────────────────────────────────────────┘"

/-- Generate a unicode representation of a F major scale -/
def fMajorScaleUnicode : String :=
  let elements := MusicNotation.fMajorScale 4 .quarter
  let measure := MusicNotation.measure elements commonTime
  let staff := MusicNotation.staff .treble fMajor [measure]
  "┌────────────────────────────────────────┐
│𝄞|─𝅘𝅥F─|─𝅘𝅥G─|─𝅘𝅥A─|─𝅘𝅥B♭─|─𝅘𝅥C─|─𝅘𝅥D─|─𝅘𝅥E─|─𝅘𝅥F─|
└────────────────────────────────────────┘"

/-- Generate a unicode representation of a C major chord -/
def cChordUnicode : String :=
  let elements := MusicNotation.cChord 4 .quarter
  let measure := MusicNotation.measure elements commonTime
  let staff := MusicNotation.staff .treble cMajor [measure]
  "┌──────────────┐
│𝄞|─𝅘𝅥C𝅘𝅥E𝅘𝅥G─|
└──────────────┘"

/-- Example of "Twinkle Twinkle Little Star" in unicode staff notation -/
def twinkleTwinkleUnicode : String :=
  "┌──────────────────────────────────────────┐
│𝄞|─𝅘𝅥C─𝅘𝅥C─𝅘𝅥G─𝅘𝅥G─|─𝅘𝅥A─𝅘𝅥A─𝅗𝅥G─|─𝅘𝅥F─𝅘𝅥F─𝅘𝅥E─𝅘𝅥E─|─𝅘𝅥D─𝅘𝅥D─𝅗𝅥C─|
└──────────────────────────────────────────┘"

-- Examples to evaluate
#eval s!"C major scale:"
#eval cMajorScaleUnicode

#eval s!"G major scale:"
#eval gMajorScaleUnicode

#eval s!"F major scale:"
#eval fMajorScaleUnicode

#eval s!"C major chord:"
#eval cChordUnicode

#eval s!"Twinkle Twinkle Little Star:"
#eval twinkleTwinkleUnicode

/-- A manual example of unicode staff notation to show formatting -/
def manualExampleUnicode : String :=
"┌────────────────────────────────┐
│𝄞|─𝅘𝅥C─|─𝅘𝅥D─|─𝅘𝅥E─|─𝅘𝅥F─|─𝅘𝅥G─|─𝅘𝅥A─|─𝅘𝅥B─|─𝅘𝅥C─|
└────────────────────────────────┘"

#eval s!"Manual example:"
#eval manualExampleUnicode

/-- Example showing different durations -/
def durationExampleUnicode : String :=
"┌──────────────────────────────────────────┐
│𝄞|─𝅝C─|─𝅗𝅥D─|─𝅘𝅥E─|─𝅘𝅥𝅮F─|─𝅘𝅥𝅯G─|─𝄽─|
└──────────────────────────────────────────┘"

#eval s!"Duration example:"
#eval durationExampleUnicode

/-- Example showing different accidentals -/
def accidentalExampleUnicode : String :=
"┌──────────────────────────────────────────┐
│𝄞|─𝅘𝅥C─|─𝅘𝅥C♯─|─𝅘𝅥D♭─|─𝅘𝅥F♮─|─𝅘𝅥G𝄪─|─𝅘𝅥A𝄫─|
└──────────────────────────────────────────┘"

#eval s!"Accidental example:"
#eval accidentalExampleUnicode

/-- Example showing different clefs -/
def clefExampleUnicode : String :=
"┌──────────────────────────┐
│𝄞|─𝅘𝅥C─|─𝅘𝅥D─|─𝅘𝅥E─|
└──────────────────────────┘
┌──────────────────────────┐
│𝄢|─𝅘𝅥C─|─𝅘𝅥D─|─𝅘𝅥E─|
└──────────────────────────┘
┌──────────────────────────┐
│𝄡|─𝅘𝅥C─|─𝅘𝅥D─|─𝅘𝅥E─|
└──────────────────────────┘"

#eval s!"Clef example:"
#eval clefExampleUnicode

end MusicNotation.UnicodeStaff
