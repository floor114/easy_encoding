require 'easy_encoding/configuration'

module EasyEncoding
  class Node
    include Comparable

    attr_reader :frequency, :symbol, :left, :right
    attr_accessor :parent

    def initialize(params)
      @frequency = params.fetch(:frequency, 0)
      @symbol = params.fetch(:symbol, '')
      @left = params.fetch(:left, nil)
      @right = params.fetch(:right, nil)
      @parent = params.fetch(:parent, nil)
    end

    def walk(&block)
      walk_node('', &block)
    end

    def walk_node(code, &block)
      yield(self, code)
      left&.walk_node(code + EasyEncoding.configuration.left_node_symbol.to_s, &block)
      right&.walk_node(code + EasyEncoding.configuration.right_node_symbol.to_s, &block)
    end

    def <=>(other)
      return nil unless other.is_a?(self.class)

      frequency <=> other.frequency
    end

    def merged?
      symbol == ''
    end
  end
end
