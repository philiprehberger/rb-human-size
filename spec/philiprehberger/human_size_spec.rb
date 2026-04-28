# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Philiprehberger::HumanSize do
  describe '.format' do
    it 'formats 0 bytes' do
      expect(described_class.format(0)).to eq('0 B')
    end

    it 'formats bytes below 1000' do
      expect(described_class.format(500)).to eq('500 B')
    end

    it 'formats kilobytes' do
      expect(described_class.format(1500)).to eq('1.5 KB')
    end

    it 'formats megabytes' do
      expect(described_class.format(1_500_000)).to eq('1.5 MB')
    end

    it 'formats gigabytes' do
      expect(described_class.format(1_500_000_000)).to eq('1.5 GB')
    end

    it 'formats terabytes' do
      expect(described_class.format(1_500_000_000_000)).to eq('1.5 TB')
    end

    it 'formats petabytes' do
      expect(described_class.format(1_500_000_000_000_000)).to eq('1.5 PB')
    end

    it 'formats exabytes' do
      expect(described_class.format(1_500_000_000_000_000_000)).to eq('1.5 EB')
    end

    context 'with binary units' do
      it 'formats kibibytes' do
        expect(described_class.format(1536, binary: true)).to eq('1.5 KiB')
      end

      it 'formats mebibytes' do
        expect(described_class.format(1_572_864, binary: true)).to eq('1.5 MiB')
      end

      it 'formats gibibytes' do
        expect(described_class.format(1_610_612_736, binary: true)).to eq('1.5 GiB')
      end

      it 'formats exbibytes' do
        expect(described_class.format(1_729_382_256_910_270_464, binary: true)).to eq('1.5 EiB')
      end
    end

    context 'with precision' do
      it 'formats with precision 0' do
        expect(described_class.format(1_500_000, precision: 0)).to eq('2 MB')
      end

      it 'formats with precision 3' do
        expect(described_class.format(1_234_567, precision: 3)).to eq('1.235 MB')
      end

      it 'formats with default precision 2' do
        expect(described_class.format(1_234_567)).to eq('1.23 MB')
      end
    end

    it 'formats negative bytes' do
      expect(described_class.format(-1_500_000)).to eq('-1.5 MB')
    end

    it 'formats exact unit boundaries' do
      expect(described_class.format(1000)).to eq('1 KB')
    end

    it 'raises Error for non-numeric input' do
      expect { described_class.format('hello') }.to raise_error(described_class::Error)
    end

    context 'with compact: true' do
      it 'omits the space between value and unit for SI sizes' do
        expect(described_class.format(1_500_000, compact: true)).to eq('1.5MB')
      end

      it 'omits the space for binary sizes' do
        expect(described_class.format(1_572_864, binary: true, compact: true)).to eq('1.5MiB')
      end

      it 'omits the space for sub-base byte values' do
        expect(described_class.format(500, compact: true)).to eq('500B')
      end

      it 'omits the space for zero' do
        expect(described_class.format(0, compact: true)).to eq('0B')
      end

      it 'preserves the space when compact is false (default)' do
        expect(described_class.format(1_500_000)).to eq('1.5 MB')
      end
    end
  end

  describe '.format_compact' do
    it 'formats SI sizes without separator' do
      expect(described_class.format_compact(1_500_000)).to eq('1.5MB')
    end

    it 'forwards binary option to format' do
      expect(described_class.format_compact(1_572_864, binary: true)).to eq('1.5MiB')
    end

    it 'forwards precision option to format' do
      expect(described_class.format_compact(1_234_567, precision: 1)).to eq('1.2MB')
    end
  end

  describe '.format_parts' do
    it 'returns value and unit for megabytes' do
      result = described_class.format_parts(1_500_000)
      expect(result).to eq({ value: 1.5, unit: 'MB' })
    end

    it 'returns value and unit for binary units' do
      result = described_class.format_parts(1_572_864, binary: true)
      expect(result).to eq({ value: 1.5, unit: 'MiB' })
    end

    it 'returns zero with B unit' do
      result = described_class.format_parts(0)
      expect(result).to eq({ value: 0.0, unit: 'B' })
    end

    it 'respects precision' do
      result = described_class.format_parts(1_234_567, precision: 3)
      expect(result).to eq({ value: 1.235, unit: 'MB' })
    end

    it 'returns bytes for small values' do
      result = described_class.format_parts(500)
      expect(result).to eq({ value: 500.0, unit: 'B' })
    end

    it 'raises Error for non-numeric input' do
      expect { described_class.format_parts('hello') }.to raise_error(described_class::Error)
    end
  end

  describe '.parse' do
    it 'parses bytes' do
      expect(described_class.parse('0 B')).to eq(0)
    end

    it 'parses gigabytes' do
      expect(described_class.parse('1.5 GB')).to eq(1_500_000_000)
    end

    it 'parses kibibytes' do
      expect(described_class.parse('500 KiB')).to eq(512_000)
    end

    it 'parses terabytes' do
      expect(described_class.parse('1 TB')).to eq(1_000_000_000_000)
    end

    it 'parses exabytes' do
      expect(described_class.parse('1 EB')).to eq(1_000_000_000_000_000_000)
    end

    it 'parses exbibytes' do
      expect(described_class.parse('1 EiB')).to eq(1_152_921_504_606_846_976)
    end

    it 'parses case-insensitively' do
      expect(described_class.parse('1.5 gb')).to eq(1_500_000_000)
    end

    it 'parses with extra whitespace' do
      expect(described_class.parse('  1.5  MB  ')).to eq(1_500_000)
    end

    it 'raises Error for unparseable input' do
      expect { described_class.parse('not a size') }.to raise_error(described_class::Error)
    end

    it 'raises Error for unknown unit' do
      expect { described_class.parse('100 XB') }.to raise_error(described_class::Error)
    end

    it 'raises Error for non-string input' do
      expect { described_class.parse(123) }.to raise_error(described_class::Error)
    end
  end

  describe '.valid?' do
    it 'returns true for valid SI strings' do
      expect(described_class.valid?('1.5 GB')).to be true
    end

    it 'returns true for valid binary strings' do
      expect(described_class.valid?('500 KiB')).to be true
    end

    it 'returns true for exabytes' do
      expect(described_class.valid?('1 EB')).to be true
    end

    it 'returns false for unparseable strings' do
      expect(described_class.valid?('not a size')).to be false
    end

    it 'returns false for unknown units' do
      expect(described_class.valid?('100 XB')).to be false
    end

    it 'returns false for non-string input' do
      expect(described_class.valid?(123)).to be false
    end
  end

  describe 'roundtrip' do
    it 'roundtrips SI format and parse' do
      original = 1_500_000
      formatted = described_class.format(original)
      parsed = described_class.parse(formatted)
      expect(parsed).to eq(original)
    end

    it 'roundtrips binary format and parse' do
      original = 1_572_864
      formatted = described_class.format(original, binary: true)
      parsed = described_class.parse(formatted)
      expect(parsed).to eq(original)
    end

    it 'roundtrips zero' do
      formatted = described_class.format(0)
      parsed = described_class.parse(formatted)
      expect(parsed).to eq(0)
    end

    it 'roundtrips exabytes' do
      original = 1_500_000_000_000_000_000
      formatted = described_class.format(original)
      parsed = described_class.parse(formatted)
      expect(parsed).to eq(original)
    end
  end

  describe '.convert' do
    it 'converts bytes to MB with default precision' do
      expect(described_class.convert(1_500_000, unit: 'MB')).to eq('1.50 MB')
    end

    it 'converts bytes to MiB' do
      expect(described_class.convert(1024 * 1024, unit: 'MiB')).to eq('1.00 MiB')
    end

    it 'raises Error for unknown unit' do
      expect { described_class.convert(1000, unit: 'XB') }.to raise_error(described_class::Error)
    end

    it 'respects precision 0' do
      expect(described_class.convert(1_500_000, unit: 'MB', precision: 0)).to eq('2 MB')
    end

    it 'handles zero bytes' do
      expect(described_class.convert(0, unit: 'KB')).to eq('0.00 KB')
    end

    it 'converts exabytes' do
      expect(described_class.convert(10**18, unit: 'EB')).to eq('1.00 EB')
    end
  end

  describe 'edge cases' do
    it 'handles negative values' do
      result = described_class.format(-500)
      expect(result).to eq('-500 B')
    end

    it 'handles zero' do
      expect(described_class.format(0)).to eq('0 B')
    end
  end

  describe '.format_rate' do
    it 'formats a basic throughput in SI units' do
      # 1.5 MB/s = 1_500_000 bytes per 1 second
      expect(described_class.format_rate(1_500_000, 1)).to eq('1.5 MB/s')
    end

    it 'formats a basic throughput in binary units' do
      expect(described_class.format_rate(1_048_576, 1, binary: true)).to eq('1 MiB/s')
    end

    it 'divides bytes by seconds before formatting' do
      # 3 MB over 2 seconds ⇒ 1.5 MB/s
      expect(described_class.format_rate(3_000_000, 2)).to eq('1.5 MB/s')
    end

    it 'supports fractional seconds' do
      expect(described_class.format_rate(500_000, 0.5)).to eq('1 MB/s')
    end

    it 'raises when seconds is zero' do
      expect { described_class.format_rate(1000, 0) }.to raise_error(Philiprehberger::HumanSize::Error)
    end

    it 'raises when seconds is negative' do
      expect { described_class.format_rate(1000, -1) }.to raise_error(Philiprehberger::HumanSize::Error)
    end

    it 'raises when seconds is non-numeric' do
      expect { described_class.format_rate(1000, '1s') }.to raise_error(Philiprehberger::HumanSize::Error)
    end

    it 'respects custom precision' do
      expect(described_class.format_rate(1_234_567, 1, precision: 3)).to eq('1.235 MB/s')
    end
  end
end
