# Music Notation System

A pure functional music notation system implemented in Lean 4. This system provides data structures and functions to represent and manipulate musical scores with Unicode-based notation.

## Features

- Core data structures for representing music notation:
  - Notes, pitches, durations, and rests
  - Measures, staves, and scores
  - Clefs, key signatures, and time signatures
- Convenient constructors for creating musical elements
- Helper functions for common musical patterns (scales, chords)
- String formatting for visualization with Unicode support (♯, ♭, 𝄞, etc.)
- Standalone module for independent usage

## Getting Started

### Prerequisites

- Lean 4
- Lake (Lean's package manager)

### Building and Running

```bash
lake build
lake exe musicnotation
```

Or use Just commands:

```bash
just build
just run
just build-run  # Build and run in one command
```

## Example Usage

Creating a C major scale:

```lean
import MusicNotation.Notation

open MusicNotation

def myScale : Staff := 
  staff .treble cMajor [measure (cMajorScale 4 .quarter) commonTime]
```

Creating a chord progression:

```lean
import MusicNotation.Notation

open MusicNotation

def myChordProgression : Staff := Id.run do
  let cMeasure := measure (cChord 4 .quarter) commonTime
  let fMeasure := measure (fChord 4 .quarter) commonTime
  let gMeasure := measure (gChord 4 .quarter) commonTime
  
  return staff .treble cMajor [cMeasure, fMeasure, gMeasure, cMeasure]
```

## Project Structure

- `MusicNotation/Basic.lean`: Core data types and structures
- `MusicNotation/Notation.lean`: Convenient constructors and helpers
- `MusicNotation/Visualization.lean`: String conversion for visualization
- `MusicNotation/Examples.lean`: Example usages and demonstrations
- `MusicNotation/Standalone.lean`: Independent module for standalone usage

## Development

Use the Justfile for common development tasks:

```bash
just format  # Format code according to Lean style guide
just clean   # Clean build artifacts
just rebuild # Clean and rebuild the project
```

## License

This project is open source and available under the MIT License.

## Acknowledgments

- Inspired by the Lean 4 Maze and Chess examples