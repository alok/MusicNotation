# Justfile for MusicNotation

# Default command when just is invoked without arguments
default:
    @just --list

# Build the project
build:
    lake build

# Run the main program
run:
    lake exe MusicNotation

# Build and run in one command
build-run: build run

# Clean build artifacts
clean:
    lake clean

# Rebuild the project
rebuild: clean build

# Run examples
examples: build
    lake exe MusicNotation

# Format the Lean code
format:
    find . -name "*.lean" -not -path "./build/*" -not -path "./.lake/*" | xargs -I{} lean --run import Lake.Format -- --stdin < {} | sponge {}

# Create commit
commit MESSAGE:
    jj commit -m "{{MESSAGE}}"

# Push commits
push:
    jj git push 