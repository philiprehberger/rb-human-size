# philiprehberger-human_size

[![Tests](https://github.com/philiprehberger/rb-human-size/actions/workflows/ci.yml/badge.svg)](https://github.com/philiprehberger/rb-human-size/actions/workflows/ci.yml)
[![Gem Version](https://badge.fury.io/rb/philiprehberger-human_size.svg)](https://rubygems.org/gems/philiprehberger-human_size)
[![Last updated](https://img.shields.io/github/last-commit/philiprehberger/rb-human-size)](https://github.com/philiprehberger/rb-human-size/commits/main)

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

Philiprehberger::HumanSize.format(1_500_000)  # => "1.5 MB"
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

### Fixed-unit formatting

Use `convert` to format bytes to a specific unit (rather than auto-picking the largest fitting unit). The `precision` option controls the number of decimal places (default is 2):

```ruby
Philiprehberger::HumanSize.convert(1_500_000, unit: "MB")              # => "1.50 MB"
Philiprehberger::HumanSize.convert(1024 * 1024, unit: "MiB")           # => "1.00 MiB"
Philiprehberger::HumanSize.convert(1_500_000, unit: "MB", precision: 0) # => "2 MB"
```

### Throughput (rate) formatting

Format a byte count and an elapsed duration into a human-readable `/s` rate. Raises `HumanSize::Error` for non-positive durations:

```ruby
Philiprehberger::HumanSize.format_rate(1_500_000, 1)                  # => "1.5 MB/s"
Philiprehberger::HumanSize.format_rate(3_000_000, 2)                  # => "1.5 MB/s"
Philiprehberger::HumanSize.format_rate(1_048_576, 1, binary: true)    # => "1 MiB/s"
Philiprehberger::HumanSize.format_rate(500_000, 0.5)                  # => "1 MB/s"
```

### Parsing

Parse human-readable byte strings back to integer byte counts. Parsing is case-insensitive and supports both SI and binary units:

```ruby
Philiprehberger::HumanSize.parse("1.5 GB")   # => 1500000000
Philiprehberger::HumanSize.parse("500 KiB")  # => 512000
Philiprehberger::HumanSize.parse("1 TB")     # => 1000000000000
Philiprehberger::HumanSize.parse("2.5 MiB")  # => 2621440
```

### Structured Output

Use `format_parts` to get the numeric value and unit separately:

```ruby
Philiprehberger::HumanSize.format_parts(1_500_000)                  # => { value: 1.5, unit: "MB" }
Philiprehberger::HumanSize.format_parts(1_572_864, binary: true)    # => { value: 1.5, unit: "MiB" }
Philiprehberger::HumanSize.format_parts(0)                          # => { value: 0.0, unit: "B" }
```

### Validation

Check if a string is a valid byte size without raising:

```ruby
Philiprehberger::HumanSize.valid?("1.5 GB")   # => true
Philiprehberger::HumanSize.valid?("nope")      # => false
Philiprehberger::HumanSize.valid?(123)          # => false
```

## API

| Method | Description |
|--------|-------------|
| `HumanSize.format(bytes, binary: false, precision: 2)` | Convert integer bytes to a human-readable string (SI or binary units) |
| `HumanSize.format_parts(bytes, binary: false, precision: 2)` | Return a hash with `:value` (Float) and `:unit` (String) |
| `HumanSize.convert(bytes, unit:, precision: 2)` | Format bytes to a specific unit (e.g. `'MB'`, `'GiB'`); raises `HumanSize::Error` on unknown units |
| `HumanSize.format_rate(bytes, seconds, binary: false, precision: 2)` | Format a throughput as a human-readable `/s` rate; raises on non-positive `seconds` |
| `HumanSize.parse(string)` | Parse a human-readable byte string back to an integer byte count |
| `HumanSize.valid?(string)` | Check if a string is a valid parseable byte size |

## Development

```bash
bundle install
bundle exec rspec
bundle exec rubocop
```

## Support

If you find this project useful:

⭐ [Star the repo](https://github.com/philiprehberger/rb-human-size)

🐛 [Report issues](https://github.com/philiprehberger/rb-human-size/issues?q=is%3Aissue+is%3Aopen+label%3Abug)

💡 [Suggest features](https://github.com/philiprehberger/rb-human-size/issues?q=is%3Aissue+is%3Aopen+label%3Aenhancement)

❤️ [Sponsor development](https://github.com/sponsors/philiprehberger)

🌐 [All Open Source Projects](https://philiprehberger.com/open-source-packages)

💻 [GitHub Profile](https://github.com/philiprehberger)

🔗 [LinkedIn Profile](https://www.linkedin.com/in/philiprehberger)

## License

[MIT](LICENSE)
