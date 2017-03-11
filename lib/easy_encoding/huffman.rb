require 'easy_encoding/node'
require 'easy_encoding/base'

module EasyEncoding
  class Huffman < Base
    def root
      @root ||= create_tree!
    end

    private

    def generate_codes!
      {}.tap { |res| root.walk { |node, code| res[node.symbol] = code unless node.merged? } }
        .sort_by { |_, value| value.length }.to_h
    end

    def create_tree!
      nodes = [].tap { |res| frequencies.each { |sym, freq| res << Node.new(symbol: sym, frequency: freq) } }

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
