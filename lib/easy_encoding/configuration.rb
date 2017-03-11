module EasyEncoding
  class Configuration
    attr_accessor :right_node_symbol, :left_node_symbol

    def initialize
      @right_node_symbol = '1'
      @left_node_symbol  = '0'
    end
  end
end
