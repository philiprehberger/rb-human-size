# Changelog

All notable changes to this gem will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this gem adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
n## [0.1.4] - 2026-03-22

### Changed
- Fix README badges
n## [0.1.3] - 2026-03-22

### Changed
- Add License badge to README

## [0.1.2] - 2026-03-22

### Fixed

- Fix CHANGELOG header wording
- Add bug_tracker_uri to gemspec

## [0.1.0] - 2026-03-22

### Added

- `HumanSize.format` to convert integer bytes to human-readable strings
- `HumanSize.parse` to parse human-readable byte strings back to integers
- SI units support (B, KB, MB, GB, TB, PB) with base 1000
- Binary units support (B, KiB, MiB, GiB, TiB, PiB) with base 1024
- Configurable decimal precision
- Case-insensitive unit parsing

[0.1.0]: https://github.com/philiprehberger/rb-human-size/releases/tag/v0.1.0
