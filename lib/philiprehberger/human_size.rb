# frozen_string_literal: true

require_relative 'human_size/version'

module Philiprehberger
  module HumanSize
    class Error < StandardError; end

    SI_UNITS = %w[B KB MB GB TB PB EB].freeze
    BINARY_UNITS = %w[B KiB MiB GiB TiB PiB EiB].freeze

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
      'EB' => 1000**6,
      'KIB' => 1024,
      'MIB' => 1024**2,
      'GIB' => 1024**3,
      'TIB' => 1024**4,
      'PIB' => 1024**5,
      'EIB' => 1024**6
    }.freeze

    # Format a byte count as a human-readable string
    #
    # @param bytes [Numeric] the number of bytes
    # @param binary [Boolean] use binary units (base 1024) instead of SI (base 1000)
    # @param precision [Integer] number of decimal places
    # @return [String] the formatted string
    # @raise [Error] if bytes is not a Numeric
    def self.format(bytes, binary: false, precision: 2)
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
                  elsif size == size.to_i
                    size.to_i.to_s
                  else
                    format_number(negative ? -size : size, precision)
                  end

      formatted = "-#{format_number(size, precision)}" if negative && unit_index.positive? && size != size.to_i

      "#{formatted} #{units[unit_index]}"
    end

    # Parse a human-readable byte string back to bytes
    #
    # @param string [String] the human-readable string (e.g., "1.5 GB", "500 KiB")
    # @return [Integer] the number of bytes
    # @raise [Error] if the string cannot be parsed
    def self.parse(string)
      raise Error, 'input must be a String' unless string.is_a?(String)

      match = PARSE_PATTERN.match(string.strip)
      raise Error, "cannot parse: #{string.inspect}" unless match

      number = match[1].to_f
      unit = match[2].upcase
      factor = UNIT_FACTORS[unit]

      raise Error, "unknown unit: #{match[2]}" unless factor

      (number * factor).round
    end

    # @api private
    def self.format_number(number, precision)
      result = sprintf("%.#{precision}f", number)
      result.sub(/\.?0+\z/, '') if precision.positive?
      result = sprintf("%.#{precision}f", number)
      # Remove trailing zeros but keep at least one decimal if precision > 0
      result.sub(/0+\z/, '').sub(/\.\z/, '')
    end

    private_class_method :format_number
  end
end
