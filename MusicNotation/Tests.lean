import MusicNotation.Basic
import MusicNotation.Notation
import MusicNotation.UnicodeStaff
import Lean

/-!
# MusicNotation.Tests

This module contains tests for the music notation system.
-/

namespace MusicNotation.Tests

open MusicNotation
open MusicNotation.UnicodeStaff

/-- Test the creation of a C major scale -/
def testCMajorScale : IO Unit := do
  let scale := cMajorScale 4 .quarter
  IO.println "C Major Scale:"
  IO.println (scale.map (fun e =>
    match e with
    | .note n => s!"Note: {noteNameToLetter n.pitch.name}{accidentalToUnicode n.pitch.accidental} {n.pitch.octave}"
    | .rest r => s!"Rest"))
  IO.println "Unicode Staff Representation:"
  IO.println cMajorScaleUnicode

/-- Test the creation of a G major scale -/
def testGMajorScale : IO Unit := do
  let scale := gMajorScale 4 .quarter
  IO.println "G Major Scale:"
  IO.println (scale.map (fun e =>
    match e with
    | .note n => s!"Note: {noteNameToLetter n.pitch.name}{accidentalToUnicode n.pitch.accidental} {n.pitch.octave}"
    | .rest r => s!"Rest"))
  IO.println "Unicode Staff Representation:"
  IO.println gMajorScaleUnicode

/-- Test the creation of a F major scale -/
def testFMajorScale : IO Unit := do
  let scale := fMajorScale 4 .quarter
  IO.println "F Major Scale:"
  IO.println (scale.map (fun e =>
    match e with
    | .note n => s!"Note: {noteNameToLetter n.pitch.name}{accidentalToUnicode n.pitch.accidental} {n.pitch.octave}"
    | .rest r => s!"Rest"))
  IO.println "Unicode Staff Representation:"
  IO.println fMajorScaleUnicode

/-- Test the creation of chords -/
def testChords : IO Unit := do
  let cChord := cChord 4 .quarter
  let gChord := gChord 4 .quarter
  let fChord := fChord 4 .quarter

  IO.println "C Major Chord:"
  IO.println (cChord.map (fun e =>
    match e with
    | .note n => s!"Note: {noteNameToLetter n.pitch.name}{accidentalToUnicode n.pitch.accidental} {n.pitch.octave}"
    | .rest r => s!"Rest"))
  IO.println "Unicode Staff Representation:"
  IO.println cChordUnicode

  IO.println "\nG Major Chord:"
  IO.println (gChord.map (fun e =>
    match e with
    | .note n => s!"Note: {noteNameToLetter n.pitch.name}{accidentalToUnicode n.pitch.accidental} {n.pitch.octave}"
    | .rest r => s!"Rest"))

  IO.println "\nF Major Chord:"
  IO.println (fChord.map (fun e =>
    match e with
    | .note n => s!"Note: {noteNameToLetter n.pitch.name}{accidentalToUnicode n.pitch.accidental} {n.pitch.octave}"
    | .rest r => s!"Rest"))

/-- Test Twinkle Twinkle Little Star -/
def testTwinkleTwinkle : IO Unit := do
  IO.println "Twinkle Twinkle Little Star:"
  IO.println "Unicode Staff Representation:"
  IO.println twinkleTwinkleUnicode

/-- Test Different Durations -/
def testDurations : IO Unit := do
  let elements := [
    c 4 .whole,
    d 4 .half,
    e 4 .quarter,
    f 4 .eighth,
    g 4 .sixteenth,
    rest .quarter
  ]

  IO.println "Different Durations:"
  IO.println (elements.map (fun e =>
    match e with
    | .note n => s!"Note: {noteNameToLetter n.pitch.name} {durationToUnicode n.duration}"
    | .rest r => s!"Rest: {durationToUnicode r.duration}"))
  IO.println "Unicode Example:"
  IO.println durationExampleUnicode

/-- Test Different Accidentals -/
def testAccidentals : IO Unit := do
  let elements := [
    c 4 .quarter .natural,
    c 4 .quarter .sharp,
    d 4 .quarter .flat,
    f 4 .quarter .natural,
    g 4 .quarter .doubleSharp,
    a 4 .quarter .doubleFlat
  ]

  IO.println "Different Accidentals:"
  IO.println (elements.map (fun e =>
    match e with
    | .note n => s!"Note: {noteNameToLetter n.pitch.name}{accidentalToUnicode n.pitch.accidental}"
    | .rest r => s!"Rest"))
  IO.println "Unicode Example:"
  IO.println accidentalExampleUnicode

/-- Test Different Clefs -/
def testClefs : IO Unit := do
  let elements := [c 4 .quarter, d 4 .quarter, e 4 .quarter]
  let measure := measure elements commonTime

  let trebleStaff := staff .treble cMajor [measure]
  let bassStaff := staff .bass cMajor [measure]
  let altoStaff := staff .alto cMajor [measure]

  IO.println "Different Clefs:"
  IO.println (s!"Treble: {clefToUnicode .treble}")
  IO.println (s!"Bass: {clefToUnicode .bass}")
  IO.println (s!"Alto: {clefToUnicode .alto}")
  IO.println "Unicode Example:"
  IO.println clefExampleUnicode

/-- Run all tests -/
def runTests : IO Unit := do
  IO.println "Running MusicNotation tests...\n"

  IO.println "=== Scale Tests ==="
  testCMajorScale
  IO.println ""
  testGMajorScale
  IO.println ""
  testFMajorScale
  IO.println ""

  IO.println "=== Chord Tests ==="
  testChords
  IO.println ""

  IO.println "=== Melody Tests ==="
  testTwinkleTwinkle
  IO.println ""

  IO.println "=== Duration Tests ==="
  testDurations
  IO.println ""

  IO.println "=== Accidental Tests ==="
  testAccidentals
  IO.println ""

  IO.println "=== Clef Tests ==="
  testClefs
  IO.println ""

  IO.println "All tests completed!"

-- Run the tests
def main : IO Unit := runTests

end MusicNotation.Tests
