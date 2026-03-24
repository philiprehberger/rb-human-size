# philiprehberger-human_size

[![Tests](https://github.com/philiprehberger/rb-human-size/actions/workflows/ci.yml/badge.svg)](https://github.com/philiprehberger/rb-human-size/actions/workflows/ci.yml)
[![Gem Version](https://badge.fury.io/rb/philiprehberger-human_size.svg)](https://rubygems.org/gems/philiprehberger-human_size)
[![License](https://img.shields.io/github/license/philiprehberger/rb-human-size)](LICENSE)

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
require 'philiprehberger/human_size'

# Format bytes to human-readable strings
Philiprehberger::HumanSize.format(1_500_000)                # => "1.5 MB"
Philiprehberger::HumanSize.format(1_572_864, binary: true)  # => "1.5 MiB"
Philiprehberger::HumanSize.format(1_500_000, precision: 0)  # => "2 MB"

# Parse human-readable strings back to bytes
Philiprehberger::HumanSize.parse('1.5 GB')   # => 1500000000
Philiprehberger::HumanSize.parse('500 KiB')  # => 512000
Philiprehberger::HumanSize.parse('1 TB')     # => 1000000000000
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

MIT
