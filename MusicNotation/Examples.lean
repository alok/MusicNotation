import MusicNotation.Basic
import MusicNotation.Notation
import MusicNotation.Visualization

/-!
# MusicNotation.Examples

This module provides full examples of using the music notation system.
-/

namespace MusicNotation.Examples

open MusicNotation

/-- A more detailed staff representation with 5 lines -/
def createFiveLineStaff (clef : Clef) (elements : List MusicalElement) : String :=
  let noteStr := String.intercalate " " (elements.map musicalElementToStaffString)
  let width := noteStr.length + 15  -- Add some padding
  let clefStr := clefToString clef
  let staffLine := String.mk (List.replicate width '─')
  let emptyLine := String.mk (List.replicate width ' ')
  
  -- Create the 5 lines of a standard staff with Unicode box-drawing
  "┌" ++ staffLine ++ "┐\n" ++
  "│" ++ emptyLine ++ "│\n" ++  -- Line 1
  "│" ++ emptyLine ++ "│\n" ++  -- Line 2
  "│ " ++ clefStr ++ " " ++ noteStr ++ "   │\n" ++  -- Line 3 (with notes)
  "│" ++ emptyLine ++ "│\n" ++  -- Line 4
  "│" ++ emptyLine ++ "│\n" ++  -- Line 5
  "└" ++ staffLine ++ "┘"

/-- C Major Scale with detailed staff notation -/
def detailedCMajorScale : String :=
  createFiveLineStaff .treble (cMajorScale 4 .quarter)

/-- Twinkle Twinkle Little Star with more detailed staff -/
def detailedTwinkleTwinkle : String := Id.run do
  let firstPhrase := [
    c 4 .quarter, c 4 .quarter, g 4 .quarter, g 4 .quarter,
    a 4 .quarter, a 4 .quarter, g 4 .half
  ]
  
  let secondPhrase := [
    f 4 .quarter, f 4 .quarter, e 4 .quarter, e 4 .quarter,
    d 4 .quarter, d 4 .quarter, c 4 .half
  ]
  
  let firstLine := createFiveLineStaff .treble firstPhrase
  let secondLine := createFiveLineStaff .treble secondPhrase
  
  firstLine ++ "\n\n" ++ secondLine

/-- Example with multiple different elements -/
def mixedExample : String := Id.run do
  let elements := [
    c 4 .quarter,
    rest .quarter,
    e 4 .eighth,
    g 4 .eighth,
    c 5 (Duration.dotted .quarter)
  ]
  
  createFiveLineStaff .treble elements

/-- Example of full piece with multiple staffs -/
def simplePiece : String := Id.run do
  -- First staff - treble clef
  let trebleElements := [
    c 5 .quarter, d 5 .quarter, e 5 .quarter, f 5 .quarter,
    g 5 .quarter, a 5 .quarter, b 5 .quarter, c 6 .quarter
  ]
  
  -- Second staff - bass clef 
  let bassElements := [
    c 3 .quarter, d 3 .quarter, e 3 .quarter, f 3 .quarter,
    g 3 .quarter, a 3 .quarter, b 3 .quarter, c 4 .quarter
  ]
  
  let trebleStaff := createFiveLineStaff .treble trebleElements
  let bassStaff := createFiveLineStaff .bass bassElements
  
  -- Title and composer
  "Simple Piece\nComposer: Example\n\n" ++
  trebleStaff ++ "\n\n" ++ bassStaff

def printAllExamples : IO Unit := do
  IO.println "\n=== C Major Scale ==="
  IO.println cMajorScaleStaff
  
  IO.println "\n=== G Major Scale ==="
  IO.println gMajorScaleStaff
  
  IO.println "\n=== F Major Scale ==="
  IO.println fMajorScaleStaff
  
  IO.println "\n=== Twinkle Twinkle Little Star ==="
  IO.println twinkleTwinkleStaff
  
  IO.println "\n=== Duration Example ==="
  IO.println durationExampleStaff
  
  IO.println "\n=== Accidental Example ==="
  IO.println accidentalExampleStaff
  
  IO.println "\n=== Clef Example ==="
  IO.println clefExampleStaff
  
  IO.println "\n=== Detailed C Major Scale ==="
  IO.println detailedCMajorScale
  
  IO.println "\n=== Detailed Twinkle Twinkle ==="
  IO.println detailedTwinkleTwinkle
  
  IO.println "\n=== Mixed Example ==="
  IO.println mixedExample
  
  IO.println "\n=== Simple Piece ==="
  IO.println simplePiece

end MusicNotation.Examples

-- More examples in #eval blocks
#eval MusicNotation.Examples.detailedCMajorScale
#eval MusicNotation.Examples.detailedTwinkleTwinkle
#eval MusicNotation.Examples.mixedExample
#eval MusicNotation.Examples.simplePiece