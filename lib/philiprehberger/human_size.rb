# frozen_string_literal: true

require_relative 'human_size/version'

module Philiprehberger
  module HumanSize
    class Error < StandardError; end

    SI_UNITS = %w[B KB MB GB TB PB].freeze
    BINARY_UNITS = %w[B KiB MiB GiB TiB PiB].freeze

    SI_BASE = 1000
    BINARY_BASE = 1024

    PARSE_PATTERN = /\A\s*(-?\d+(?:\.\d+)?)\s*([a-z]+)\s*\z/i

    UNIT_FACTORS = {
      'B' => 1,
      'KB' => 1000,
      'MB' => 1000**2,
      'GB' => 1000**3,
      'TB' => 1000**4,
      'PB' => 1000**5,
      'KIB' => 1024,
      'MIB' => 1024**2,
      'GIB' => 1024**3,
      'TIB' => 1024**4,
      'PIB' => 1024**5
    }.freeze

    class << self
      def format(bytes, binary: false, precision: 2)
        raise Error, 'bytes must be a Numeric' unless bytes.is_a?(Numeric)

        units = binary ? BINARY_UNITS : SI_UNITS
        base = binary ? BINARY_BASE : SI_BASE

        return "0 #{units[0]}" if bytes.zero?

        negative = bytes.negative?
        size = bytes.abs.to_f

        unit_index = 0
        while size >= base && unit_index < units.length - 1
          size /= base
          unit_index += 1
        end

        formatted = if unit_index.zero?
                      bytes.to_i.to_s
                    else
                      number = negative ? -size : size
                      format_number(number, precision)
                    end

        "#{formatted} #{units[unit_index]}"
      end

      def parse(string)
        raise Error, 'input must be a String' unless string.is_a?(String)

        match = PARSE_PATTERN.match(string.strip)
        raise Error, "cannot parse: #{string.inspect}" unless match

        number = match[1].to_f
        unit = match[2].upcase
        factor = UNIT_FACTORS[unit]

        raise Error, "unknown unit: #{match[2]}" unless factor

        (number * factor).round
      end

      private

      def format_number(number, precision)
        result = sprintf("%.#{precision}f", number) # rubocop:disable Style/FormatString
        result.sub(/0+\z/, '').sub(/\.\z/, '')
      end
    end
  end
end
