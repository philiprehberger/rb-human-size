# Changelog

All notable changes to this gem will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this gem adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.6.0] - 2026-04-27

### Added
- `compact:` option on `HumanSize.format` — when true, omits the space between value and unit (e.g. `"1.5MB"` instead of `"1.5 MB"`); default is `false` for backwards compatibility.
- `HumanSize.format_compact(bytes, binary: false, precision: 2)` — shortcut equivalent to `format(..., compact: true)`.

## [0.5.0] - 2026-04-21

### Added
- `HumanSize.format_rate(bytes, seconds, binary: false, precision: 2)` — formats a throughput rate as a human-readable string ending in `/s` (e.g. `1.5 MB/s`); raises `HumanSize::Error` for non-positive seconds

## [0.4.0] - 2026-04-18

### Added
- `HumanSize.convert(bytes, unit:, precision: 2)` — formats bytes to a specific unit (e.g. `'MB'`, `'GiB'`) rather than auto-picking the largest fitting unit; raises `HumanSize::Error` on unknown units

## [0.3.0] - 2026-04-10

### Added
- `HumanSize.format_parts` method for structured output (returns `{ value:, unit: }` hash)
- `HumanSize.valid?` method for safe parse validation without raising
- Exabyte (EB) and exbibyte (EiB) unit support

### Fixed
- Gemspec author, email, and ruby version to match guide standards
- Issue templates to match guide (gem-version field, placeholders, alternatives)

## [0.2.2] - 2026-03-31

### Added
- Add GitHub issue templates, dependabot config, and PR template

## [0.2.1] - 2026-03-31

### Changed
- Standardize README badges, support section, and license format

## [0.2.0] - 2026-03-26

### Fixed
- Add Sponsor badge to README
- Fix license section link format

## [0.1.9] - 2026-03-24

### Changed
- Add Usage subsections to README for better feature discoverability

## [0.1.8] - 2026-03-24

### Fixed
- Fix stray character in CHANGELOG formatting

## [0.1.7] - 2026-03-24

### Fixed
- Standardize README code examples to use double-quote require statements

## [0.1.6] - 2026-03-24

### Fixed
- Standardize README API section to table format
- Fix Installation section quote style to double quotes

## [0.1.5] - 2026-03-23

### Fixed
- Standardize README to match template (installation order, code fences, license section, one-liner format)
- Update gemspec summary to match README description

## [0.1.4] - 2026-03-22

### Changed
- Fix README badges

## [0.1.3] - 2026-03-22

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

[Unreleased]: https://github.com/philiprehberger/rb-human-size/compare/v0.4.0...HEAD
[0.4.0]: https://github.com/philiprehberger/rb-human-size/compare/v0.3.0...v0.4.0
[0.3.0]: https://github.com/philiprehberger/rb-human-size/compare/v0.2.2...v0.3.0
[0.2.2]: https://github.com/philiprehberger/rb-human-size/compare/v0.2.1...v0.2.2
[0.2.1]: https://github.com/philiprehberger/rb-human-size/compare/v0.2.0...v0.2.1
[0.2.0]: https://github.com/philiprehberger/rb-human-size/compare/v0.1.9...v0.2.0
[0.1.9]: https://github.com/philiprehberger/rb-human-size/compare/v0.1.8...v0.1.9
[0.1.8]: https://github.com/philiprehberger/rb-human-size/compare/v0.1.7...v0.1.8
[0.1.7]: https://github.com/philiprehberger/rb-human-size/compare/v0.1.6...v0.1.7
[0.1.6]: https://github.com/philiprehberger/rb-human-size/compare/v0.1.5...v0.1.6
[0.1.5]: https://github.com/philiprehberger/rb-human-size/compare/v0.1.4...v0.1.5
[0.1.4]: https://github.com/philiprehberger/rb-human-size/compare/v0.1.3...v0.1.4
[0.1.3]: https://github.com/philiprehberger/rb-human-size/compare/v0.1.2...v0.1.3
[0.1.2]: https://github.com/philiprehberger/rb-human-size/compare/v0.1.0...v0.1.2
[0.1.0]: https://github.com/philiprehberger/rb-human-size/releases/tag/v0.1.0
