# Music Notation System 𝄞 ♯ ♭ 𝄆 𝄇 𝄚

A pure functional music notation system implemented in Lean 4. This system provides data structures and functions to represent and manipulate musical scores with beautiful Unicode-based notation.

## Features

- Core data structures for representing music notation:
  - Notes, pitches, durations, and rests (𝅝, 𝅗𝅥, 𝅘𝅥, 𝅘𝅥𝅮, 𝄾)
  - Measures, staves, and scores (𝄚, 𝄀, 𝄁)
  - Clefs, key signatures, and time signatures (𝄞, 𝄢, 𝄠, ♯, ♭, ♮)
- Convenient constructors for creating musical elements
- Helper functions for common musical patterns (scales, chords)
- String formatting for visualization with comprehensive Unicode support
- Standalone module for independent usage

## Unicode Font Compatibility

For the best visual experience with musical notation, use one of these fonts:

- **Bravura** - Comprehensive SMuFL-compliant music font
- **Noto Music** - Google's font with good musical symbol support
- **DejaVu Sans** - Open source font with decent music symbol support
- **STIX Two** - Scientific and technical font with music symbols
- **MusGlyphs** - Specialized music font

Most modern terminals and code editors support these symbols, but results may vary by environment.

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

Creating a C major scale with Unicode notation:

```lean
import MusicNotation.Notation

open MusicNotation

def myScale : Staff := 
  staff .treble (key c♮ .major) [measure (cMajorScale 4 .♩) 4⁄4]
```

Creating a chord progression:

```lean
import MusicNotation.Notation

open MusicNotation

def myChordProgression : Staff := Id.run do
  let cMeasure := measure (chord c♮ e♮ g♮ 4 .♩) 4⁄4
  let fMeasure := measure (chord f♮ a♮ c♮ 4 .♩) 4⁄4
  let gMeasure := measure (chord g♮ b♮ d♮ 4 .♩) 4⁄4
  
  return staff 𝄞 (key c♮ .major) [cMeasure, fMeasure, gMeasure, cMeasure]
```

Rich visualization output:

```
𝄞 ♮ 4/4 
| 𝅘𝅥 C4 𝅘𝅥 D4 𝅘𝅥 E4 𝅘𝅥 F4 | 
| 𝅘𝅥 G4 𝅘𝅥 A4 𝅘𝅥 B4 𝅘𝅥 C5 |

𝄢 ♮ 4/4
| 𝅗𝅥 C3 𝅗𝅥 G3       |
| 𝅗𝅥 F3 𝅗𝅥 C3       |
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