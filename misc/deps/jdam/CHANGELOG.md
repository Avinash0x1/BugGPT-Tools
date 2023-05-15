# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## Unreleased

## v0.2.0-alpha - 2020-12-11
### Fixed
- Handle `Uint64` and `Int64` types in `NumericToNegative`
- Handle empty objects (`{}`)
- Handle empty strings in `ByteSequenceRepeat`

### Added
- Ensure uniqueness of all fuzzed objects when using the `-count` flag.

## 0.1.1-alpha - 2020-11-30
### Fixed
- Reset `curDepth` counter `Fuzzer` after each fuzzing.

### Changed
- Manage version with ldflags

### Added
- README section on mutators, what to look for, trophy room, and credits.

## 0.1.0-alpha - 2020-11-29
### Added
- Initial release
