# Justfile for MusicNotation

# Default command when just is invoked without arguments
default:
    @just --list

# Build the project
build:
    lake build

# Run the main program
run:
    lake exe musicnotation

# Build and run in one command
build-run: build run

# Clean build artifacts
clean:
    lake clean

# Rebuild the project
rebuild: clean build

# Run examples
examples: build
    lake exe musicnotation

# Run standalone version
standalone: build
    lake exe musicnotation standalone

# Format the Lean code
format:
    find . -name "*.lean" -not -path "./build/*" -not -path "./.lake/*" | xargs -I{} lean --run import Lake.Format -- --stdin < {} | sponge {}

# Run code quality checks
lint: format
    lake lint

# Run tests
test:
    lake test

# Generate documentation
docs:
    lake doc

# Create commit
commit MESSAGE:
    git commit -m "{{MESSAGE}}"

# Push commits
push:
    git push

# Create a release
release VERSION: 
    @echo "Creating release v{{VERSION}}"
    @grep -q "## \[{{VERSION}}\]" CHANGELOG.md || (echo "Error: Version {{VERSION}} not found in CHANGELOG.md" && exit 1)
    git tag -a v{{VERSION}} -m "Release v{{VERSION}}"
    git push origin v{{VERSION}} 