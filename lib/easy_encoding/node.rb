require 'easy_encoding/configuration'

module EasyEncoding
  class Node
    include Comparable

    attr_reader :frequency, :symbol, :left, :right
    attr_accessor :parent

    def initialize(params)
      @frequency = params.fetch(:frequency, 0)
      @symbol    = params.fetch(:symbol, '')
      @left      = params[:left]
      @right     = params[:right]
      @parent    = params[:parent]
    end

    def walk(&block)
      walk_node('', &block)
    end

    def walk_node(code, &block)
      yield(self, code)
      left&.walk_node(code + EasyEncoding.configuration.left_node_symbol, &block)
      right&.walk_node(code + EasyEncoding.configuration.right_node_symbol, &block)
    end

    def <=>(other)
      frequency <=> other.frequency
    end

    def merged?
      symbol == ''
    end
  end
end
