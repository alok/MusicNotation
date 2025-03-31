import MusicNotation.Basic
import Lean

/-!
# MusicNotation.Visualization

This module provides string conversion functions to visualize music notation in a
human-readable format.
-/

namespace MusicNotation

/-- Convert a NoteNane to a string representation -/
def noteNameToString : NoteName → String
| .C => "C"
| .D => "D"
| .E => "E"
| .F => "F"
| .G => "G"
| .A => "A"
| .B => "B"

/-- Convert an Accidental to a string representation -/
def accidentalToString : Accidental → String
| .natural => "♮"
| .sharp => "♯"
| .flat => "♭"
| .doubleSharp => "𝄪"
| .doubleFlat => "𝄫"

/-- Convert a Duration to a string representation -/
def durationToString : Duration → String
| .whole => "𝅝"
| .half => "𝅗𝅥"
| .quarter => "𝅘𝅥"
| .eighth => "𝅘𝅥𝅮"
| .sixteenth => "𝅘𝅥𝅯"
| .thirtySecond => "𝅘𝅥𝅰"
| .dotted d => durationToString d ++ "."
| .triplet d => "³(" ++ durationToString d ++ ")"

/-- Convert a Pitch to a string representation -/
def pitchToString (p : Pitch) : String :=
  noteNameToString p.name ++ accidentalToString p.accidental ++ p.octave.repr

/-- Convert a Note to a string representation -/
def noteToString (n : Note) : String :=
  pitchToString n.pitch ++ durationToString n.duration

/-- Convert a Rest to a string representation -/
def restToString (r : Rest) : String :=
  "𝄽" ++ durationToString r.duration

/-- Convert a MusicalElement to a string representation -/
def musicalElementToString : MusicalElement → String
| .note n => noteToString n
| .rest r => restToString r

/-- Convert a TimeSignature to a string representation -/
def timeSignatureToString (t : TimeSignature) : String :=
  s!"{t.beats}/{t.beatValue}"

/-- Convert a KeySignature to a string representation -/
def keySignatureToString (k : KeySignature) : String :=
  if k.sharps == 0 then
    "C"
  else if k.sharps > 0 then
    let keys := ["C", "G", "D", "A", "E", "B", "F♯"]
    keys[k.sharps.toNat - 1]!
  else
    let keys := ["F", "B♭", "E♭", "A♭", "D♭", "G♭", "C♭"]
    keys[(-k.sharps).toNat - 1]!

/-- Convert a Clef to a string representation -/
def clefToString : Clef → String
| .treble => "𝄞"
| .bass => "𝄢"
| .alto => "𝄡"
| .tenor => "𝄡"  -- Same symbol as alto but positioned differently

/-- Format a measure for display -/
def formatMeasure (m : Measure) : String := Id.run do
  let mut result := "|"
  for element in m.elements do
    result := result ++ " " ++ musicalElementToString element ++ " "
  result := result ++ "|"
  result

/-- Format a staff for display -/
def formatStaff (s : Staff) : String := Id.run do
  let mut result := clefToString s.clef ++ " " ++ keySignatureToString s.keySignature ++ " "

  -- Get time signature from first measure if available
  if let some m := s.measures.head? then
    result := result ++ timeSignatureToString m.timeSignature ++ "\n"
  else
    result := result ++ "\n"

  -- Format all measures
  for m in s.measures do
    result := result ++ formatMeasure m ++ " "

  result

/-- Format a score for display -/
def formatScore (score : Score) : String := Id.run do
  let mut result := s!"Title: {score.title}\nComposer: {score.composer}\n\n"

  for staff in score.staves do
    result := result ++ formatStaff staff ++ "\n\n"

  result

end MusicNotation
