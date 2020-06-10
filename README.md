# philiprehberger-human_size

[![Tests](https://github.com/philiprehberger/rb-human-size/actions/workflows/ci.yml/badge.svg)](https://github.com/philiprehberger/rb-human-size/actions/workflows/ci.yml)
[![Gem Version](https://badge.fury.io/rb/philiprehberger-human_size.svg)](https://rubygems.org/gems/philiprehberger-human_size)
[![License](https://img.shields.io/github/license/philiprehberger/rb-human-size)](LICENSE)
[![Sponsor](https://img.shields.io/badge/sponsor-GitHub%20Sponsors-ec6cb9)](https://github.com/sponsors/philiprehberger)

Bidirectional byte size formatting with SI and binary units

## Requirements

- Ruby >= 3.1

## Installation

Add to your Gemfile:

```ruby
gem "philiprehberger-human_size"
```

Or install directly:

```bash
gem install philiprehberger-human_size
```

## Usage

```ruby
require "philiprehberger/human_size"
```

### Formatting Bytes

Convert integer bytes to human-readable strings using SI units (base 1000) by default:

```ruby
Philiprehberger::HumanSize.format(1_500_000)      # => "1.5 MB"
Philiprehberger::HumanSize.format(1_000_000_000)   # => "1 GB"
Philiprehberger::HumanSize.format(0)               # => "0 B"
```

### Binary Units

Pass `binary: true` to use IEC binary units (base 1024) instead of SI:

```ruby
Philiprehberger::HumanSize.format(1_572_864, binary: true)  # => "1.5 MiB"
Philiprehberger::HumanSize.format(1_048_576, binary: true)   # => "1 MiB"
Philiprehberger::HumanSize.format(5_368_709_120, binary: true) # => "5 GiB"
```

### Precision Control

Use the `precision` option to control the number of decimal places (default is 2). Trailing zeros are stripped automatically:

```ruby
Philiprehberger::HumanSize.format(1_500_000, precision: 0)  # => "2 MB"
Philiprehberger::HumanSize.format(1_234_567, precision: 3)  # => "1.235 MB"
Philiprehberger::HumanSize.format(1_500_000, precision: 4)  # => "1.5 MB"
```

### Parsing

Parse human-readable byte strings back to integer byte counts. Parsing is case-insensitive and supports both SI and binary units:

```ruby
Philiprehberger::HumanSize.parse("1.5 GB")   # => 1500000000
Philiprehberger::HumanSize.parse("500 KiB")  # => 512000
Philiprehberger::HumanSize.parse("1 TB")     # => 1000000000000
Philiprehberger::HumanSize.parse("2.5 MiB")  # => 2621440
```

## API

| Method | Description |
|--------|-------------|
| `HumanSize.format(bytes, binary: false, precision: 2)` | Convert integer bytes to a human-readable string (SI or binary units) |
| `HumanSize.parse(string)` | Parse a human-readable byte string back to an integer byte count |

## Development

```bash
bundle install
bundle exec rspec
bundle exec rubocop
```

## License

[MIT](LICENSE)
