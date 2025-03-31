# CLAUDE.md - Music Notation System Guidelines

## Build Commands
- Build project: `lake build` or `just build`
- Run main program: `lake exe musicnotation` or `just run`
- Build and run: `just build-run`
- Clean build artifacts: `just clean` or `lake clean`
- Format code: `just format`

## Code Style Guidelines
- **Imports**: Place core Lean imports first, followed by project-specific imports
- **Organization**: Organize code in namespaces (e.g., `namespace MusicNotation`)
- **Formatting**: Use 2-space indentation, follow `lake format` style
- **Unicode**: Prefer Unicode notation for musical symbols (♯, ♭, 𝄞, etc.)
- **Documentation**: Document types with `/--` doc comments, inline with `--`
- **Types**: Use `deriving` for common type classes (BEq, Repr, Inhabited)
- **Naming**: Use camelCase for functions, PascalCase for types
- **Error Handling**: Use `Option` type for operations that may fail
- **Examples**: Include examples in dedicated modules or `#eval` blocks
- **Visualization**: Implement string conversion for all key types

## Project Structure
- Core definitions in `Basic.lean`
- Notation helpers in `Notation.lean`
- Visualization functions in `Visualization.lean`
- Examples in `Examples.lean`

Follow the example of the maze and chess submodules for implementation patterns.