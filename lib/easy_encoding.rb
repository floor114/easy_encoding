require 'easy_encoding/version'
require 'easy_encoding/configuration'
require 'easy_encoding/huffman'
require 'easy_encoding/shannon_fano'

module EasyEncoding
  class << self
    attr_accessor :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.reset
    @configuration = Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
