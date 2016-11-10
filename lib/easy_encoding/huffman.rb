require 'easy_encoding/node'

module EasyEncoding
  class Huffman
    attr_reader :input, :char_codes, :frequencies, :root

    def initialize(input)
      case input
      when Hash
        raise ArgumentError, 'summ of frequencies should eq 1' if input.values.reduce(:+) > 1
        @frequencies = input.sort_by { |_, value| value }.reverse.to_h
      when String
        @input = input
        @frequencies = calculate_frequencies(input)
      else
        raise ArgumentError, 'you must provide a hash or a string'
      end
      @root = create_tree(frequencies)
      @char_codes = generate_codes(root)
    end

    private

    def generate_codes(root)
      {}.tap { |result| root.walk { |node, code| result[node.symbol] = code unless node.merged? } }
        .sort_by { |_, value| value.length }.to_h
    end

    def calculate_frequencies(string)
      frequencies = Hash.new(0.0)
      frequencies.tap { |freq| string.each_char { |char| freq[char.to_sym] += 1 } }
                 .each { |key, value| frequencies[key] = value / string.size }
                 .sort_by { |_, value| value }.reverse.to_h
    end

    def create_tree(frequencies)
      nodes = [].tap { |result| frequencies.each { |sym, freq| result << Node.new(symbol: sym, frequency: freq) } }

      while nodes.size > 1
        nodes.sort!
        nodes << merge_nodes(nodes.shift(2))
      end

      nodes.first
    end

    def merge_nodes(nodes)
      right_node, left_node = nodes.sort
      frequency = nodes.map(&:frequency).reduce(:+)

      node = Node.new(frequency: frequency, left: left_node, right: right_node)
      right_node.parent = left_node.parent = node

      node
    end
  end
end
