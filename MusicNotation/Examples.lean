import MusicNotation.Basic
import MusicNotation.Notation
import MusicNotation.Visualization

/-!
# MusicNotation.Examples

This module provides examples of using the music notation system.
-/

open MusicNotation

namespace MusicNotation.Examples

/-- Example of creating a C major scale in the treble clef -/
def cMajorScaleStaff : Staff := Id.run do
  -- Create a measure with the C major scale notes
  let scaleElements := cMajorScale 4 .quarter
  let scaleMeasure := measure scaleElements commonTime

  -- Create a staff with the measure
  return staff .treble cMajor [scaleMeasure]

/-- Example of creating a simple melody -/
def twinkleTwinkle : Staff := Id.run do
  -- First measure: C C G G
  let measure1 := measure [
    c 4 .quarter,
    c 4 .quarter,
    g 4 .quarter,
    g 4 .quarter
  ] commonTime

  -- Second measure: A A G -
  let measure2 := measure [
    a 4 .quarter,
    a 4 .quarter,
    g 4 .half
  ] commonTime

  -- Third measure: F F E E
  let measure3 := measure [
    f 4 .quarter,
    f 4 .quarter,
    e 4 .quarter,
    e 4 .quarter
  ] commonTime

  -- Fourth measure: D D C -
  let measure4 := measure [
    d 4 .quarter,
    d 4 .quarter,
    c 4 .half
  ] commonTime

  -- Create a staff with the measures
  return staff .treble cMajor [measure1, measure2, measure3, measure4]

/-- Example of creating a melody with notation library -/
def scaleExample : Staff :=
  staff .treble cMajor [
    measure (cMajorScale 4 .quarter) commonTime,
    measure (gMajorScale 4 .quarter) commonTime
  ]

/-- A simple chord progression -/
def cMajorChordProgression : Staff := Id.run do
  -- C major chord
  let cMeasure := measure (cChord 4 .quarter) commonTime

  -- F major chord
  let fMeasure := measure (fChord 4 .quarter) commonTime

  -- G major chord
  let gMeasure := measure (gChord 4 .quarter) commonTime

  -- C major chord again
  let cMeasure2 := measure (cChord 4 .quarter) commonTime

  -- Create a staff with the measures
  return staff .treble cMajor [cMeasure, fMeasure, gMeasure, cMeasure2]

/-- Example with rests and different durations -/
def rhythmExample : Staff := Id.run do
  -- Create a measure with various rhythms
  let measure1 := measure [
    c 4 .quarter,
    rest .quarter,
    e 4 .eighth,
    g 4 .eighth,
    c 5 (Duration.dotted .quarter)
  ] commonTime

  -- Another measure with different rhythms
  let measure2 := measure [
    g 4 .half,
    rest .eighth,
    f 4 .eighth,
    e 4 .quarter
  ] commonTime

  -- Create a staff with the measures
  return staff .treble cMajor [measure1, measure2]

/-- Print out the examples in string format -/
def printExamples : IO Unit := do
  IO.println "C Major Scale:"
  IO.println (formatStaff cMajorScaleStaff)
  IO.println "Twinkle Twinkle Little Star:"
  IO.println (formatStaff twinkleTwinkle)
  IO.println "Scale Example (C and G Major Scales):"
  IO.println (formatStaff scaleExample)
  IO.println "C Major Chord Progression:"
  IO.println (formatStaff cMajorChordProgression)
  IO.println "Rhythm Example:"
  IO.println (formatStaff rhythmExample)

end MusicNotation.Examples
