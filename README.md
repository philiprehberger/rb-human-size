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
gem 'philiprehberger-human_size'
```

Or install directly:

```bash
gem install philiprehberger-human_size
```

## Usage

```ruby
require 'philiprehberger/human_size'

Philiprehberger::HumanSize.format(1_500_000)                        # => "1.5 MB"
Philiprehberger::HumanSize.format(1_572_864, binary: true)          # => "1.5 MiB"
Philiprehberger::HumanSize.format(1_500_000, precision: 0)          # => "2 MB"
```

### Parsing

```ruby
Philiprehberger::HumanSize.parse('1.5 GB')   # => 1500000000
Philiprehberger::HumanSize.parse('500 KiB')  # => 512000
Philiprehberger::HumanSize.parse('1 TB')     # => 1000000000000
```

### Binary Units

Use `binary: true` to format with base-1024 units (KiB, MiB, GiB):

```ruby
Philiprehberger::HumanSize.format(1_073_741_824, binary: true)  # => "1 GiB"
```

### Precision

Control decimal places with the `precision` option:

```ruby
Philiprehberger::HumanSize.format(1_234_567, precision: 3)  # => "1.235 MB"
Philiprehberger::HumanSize.format(1_234_567, precision: 0)  # => "1 MB"
```

## API

| Method | Description |
|--------|-------------|
| `HumanSize.format(bytes, binary: false, precision: 2)` | Format bytes as a human-readable string |
| `HumanSize.parse(string)` | Parse a human-readable byte string back to bytes |

## Development

```bash
bundle install
bundle exec rspec      # Run tests
bundle exec rubocop    # Check code style
```

## License

MIT
