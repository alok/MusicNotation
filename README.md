# MusicNotation

A Lean 4 library for representing and visualizing musical notation.

## Overview

MusicNotation is a library for working with musical notation in Lean 4. It provides data structures and functions to represent musical elements like notes, measures, and staves, along with unicode-based visualization.

Similar to the Maze example, MusicNotation includes unicode staff visualization that shows musical notation directly in the Lean output using text characters.

## Features

- Basic musical elements: notes, rests, durations, and accidentals
- Staff representation with clefs and key signatures
- Common music structures: scales, chords, measures
- Unicode-based staff visualization
- Helper functions for creating common musical elements

## Examples

### Creating a C Major Scale

```lean
import MusicNotation.Notation
import MusicNotation.UnicodeStaff

open MusicNotation
open MusicNotation.UnicodeStaff

#eval cMajorScaleUnicode
```

Output:
```
┌────────────────────────────────┐
│𝄞|─𝅘𝅥C─|─𝅘𝅥D─|─𝅘𝅥E─|─𝅘𝅥F─|─𝅘𝅥G─|─𝅘𝅥A─|─𝅘𝅥B─|─𝅘𝅥C─|
└────────────────────────────────┘
```

### Creating a G Major Scale

```lean
#eval gMajorScaleUnicode
```

Output:
```
┌────────────────────────────────────────┐
│𝄞|─𝅘𝅥G─|─𝅘𝅥A─|─𝅘𝅥B─|─𝅘𝅥C─|─𝅘𝅥D─|─𝅘𝅥E─|─𝅘𝅥F♯─|─𝅘𝅥G─|
└────────────────────────────────────────┘
```

### Creating a C Major Chord

```lean
#eval cChordUnicode
```

Output:
```
┌──────────────┐
│𝄞|─𝅘𝅥C𝅘𝅥E𝅘𝅥G─|
└──────────────┘
```

### Simple Melody: Twinkle Twinkle Little Star

```lean
#eval twinkleTwinkleUnicode
```

Output:
```
┌──────────────────────────────────────────┐
│𝄞|─𝅘𝅥C─𝅘𝅥C─𝅘𝅥G─𝅘𝅥G─|─𝅘𝅥A─𝅘𝅥A─𝅗𝅥G─|─𝅘𝅥F─𝅘𝅥F─𝅘𝅥E─𝅘𝅥E─|─𝅘𝅥D─𝅘𝅥D─𝅗𝅥C─|
└──────────────────────────────────────────┘
```

### Different Note Durations

```lean
#eval durationExampleUnicode
```

Output:
```
┌──────────────────────────────────────────┐
│𝄞|─𝅝C─|─𝅗𝅥D─|─𝅘𝅥E─|─𝅘𝅥𝅮F─|─𝅘𝅥𝅯G─|─𝄽─|
└──────────────────────────────────────────┘
```

### Different Accidentals

```lean
#eval accidentalExampleUnicode
```

Output:
```
┌──────────────────────────────────────────┐
│𝄞|─𝅘𝅥C─|─𝅘𝅥C♯─|─𝅘𝅥D♭─|─𝅘𝅥F♮─|─𝅘𝅥G𝄪─|─𝅘𝅥A𝄫─|
└──────────────────────────────────────────┘
```

## Usage

### Creating Notes

```lean
-- Create a C4 quarter note
let c4 := c 4 .quarter

-- Create an F#5 half note
let fSharp5 := f 5 .half .sharp

-- Create a Bb3 eighth note
let bFlat3 := b 3 .eighth .flat
```

### Creating Measures

```lean
-- Create a measure with C, E, G quarter notes
let cMajorMeasure := measure [c 4, e 4, g 4] commonTime
```

### Creating Staves

```lean
-- Create a staff with a treble clef, C major key signature, and a measure
let myStaff := staff .treble cMajor [cMajorMeasure]
```

## Installation

1. Add this repository to your Lake dependencies:

```lean
require MusicNotation from git "https://github.com/yourusername/MusicNotation" @ "main"
```

2. Import the modules in your Lean files:

```lean
import MusicNotation.Basic
import MusicNotation.Notation
import MusicNotation.UnicodeStaff
```

## Development

The project uses [Just](https://github.com/casey/just) for common commands:

```
# Build the project
just build

# Run tests
just test

# Run examples
just examples
```

## License

MIT License