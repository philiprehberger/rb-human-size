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

    class << self
      def format(bytes, binary: false, precision: 2)
        parts = compute_parts(bytes, binary: binary, precision: precision)

        "#{format_value(parts[:value], parts[:unit_index], precision)} #{parts[:unit]}"
      end

      def format_parts(bytes, binary: false, precision: 2)
        parts = compute_parts(bytes, binary: binary, precision: precision)

        { value: parts[:value], unit: parts[:unit] }
      end

      def convert(bytes, unit:, precision: 2)
        raise Error, 'bytes must be a Numeric' unless bytes.is_a?(Numeric)
        raise Error, 'unit must be a String' unless unit.is_a?(String)

        key = unit.upcase
        factor = UNIT_FACTORS[key]
        raise Error, "unknown unit: #{unit}" unless factor

        value = bytes.to_f / factor
        "#{sprintf("%.#{precision}f", value)} #{unit}" # rubocop:disable Style/FormatString
      end

      # Format a throughput rate (bytes over a time window) as a human-readable
      # string suffixed with `/s` (e.g. `1.5 MB/s`, `256 KiB/s`).
      #
      # @param bytes [Numeric] bytes transferred
      # @param seconds [Numeric] elapsed time in seconds (must be > 0)
      # @param binary [Boolean] use binary units (KiB, MiB, ...)
      # @param precision [Integer] decimal precision
      # @return [String] formatted rate ending with `/s`
      # @raise [Error] if `seconds` is not a positive Numeric
      def format_rate(bytes, seconds, binary: false, precision: 2)
        raise Error, 'seconds must be a Numeric' unless seconds.is_a?(Numeric)
        raise Error, 'seconds must be positive' unless seconds.positive?

        per_second = bytes.to_f / seconds
        "#{format(per_second, binary: binary, precision: precision)}/s"
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

      def valid?(string)
        return false unless string.is_a?(String)

        parse(string)
        true
      rescue Error
        false
      end

      private

      def compute_parts(bytes, binary:, precision:)
        raise Error, 'bytes must be a Numeric' unless bytes.is_a?(Numeric)

        units = binary ? BINARY_UNITS : SI_UNITS
        base = binary ? BINARY_BASE : SI_BASE

        return { value: 0.0, unit: units[0], unit_index: 0 } if bytes.zero?

        negative = bytes.negative?
        size = bytes.abs.to_f

        unit_index = 0
        while size >= base && unit_index < units.length - 1
          size /= base
          unit_index += 1
        end

        value = if unit_index.zero?
                  bytes.to_f
                else
                  rounded = format_number(negative ? -size : size, precision).to_f
                  rounded
                end

        { value: value, unit: units[unit_index], unit_index: unit_index }
      end

      def format_value(value, unit_index, precision)
        if unit_index.zero?
          value.to_i.to_s
        else
          format_number(value, precision)
        end
      end

      def format_number(number, precision)
        result = sprintf("%.#{precision}f", number) # rubocop:disable Style/FormatString
        result.sub(/0+\z/, '').sub(/\.\z/, '')
      end
    end
  end
end
