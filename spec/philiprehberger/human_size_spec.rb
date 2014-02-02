# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Philiprehberger::HumanSize do
  it 'has a version number' do
    expect(described_class::VERSION).not_to be_nil
  end

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
    end

    context 'with precision' do
      it 'formats with precision 0' do
        expect(described_class.format(1_500_000, precision: 0)).to eq('2 MB')
      end

      it 'formats with precision 1' do
        expect(described_class.format(1_550_000, precision: 1)).to eq('1.6 MB')
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
  end

  describe '.parse' do
    it 'parses bytes' do
      expect(described_class.parse('0 B')).to eq(0)
    end

    it 'parses kilobytes' do
      expect(described_class.parse('1.5 GB')).to eq(1_500_000_000)
    end

    it 'parses kibibytes' do
      expect(described_class.parse('500 KiB')).to eq(512_000)
    end

    it 'parses terabytes' do
      expect(described_class.parse('1 TB')).to eq(1_000_000_000_000)
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
  end
end
