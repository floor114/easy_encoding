module EasyEncoding
  class Base
    attr_reader :input

    def initialize(input)
      @input = input
    end

    def char_codes
      @char_codes ||= generate_codes!
    end

    def frequencies
      @frequencies ||= calculate_frequencies!
    end

    private

    def generate_codes!; end

    def calculate_frequencies!
      case input
      when Hash
        raise ArgumentError, 'summ of frequencies should eq 1' if valid_hash_frequencies?
        hash_frequencies
      when String
        string_frequencies
      else
        raise ArgumentError, 'you must provide a hash or a string'
      end
    end

    def string_frequencies
      frequencies = Hash.new(0.0)
      frequencies.tap { |freq| input.each_char { |char| freq[char.to_sym] += 1 } }
                 .each { |key, value| frequencies[key] = value / input.size }
                 .sort_by { |_, value| value }.reverse.to_h
    end

    def hash_frequencies
      input.sort_by(&:last).reverse.to_h
    end

    def valid_hash_frequencies?
      input.values.reduce(:+) > 1
    end
  end
end
