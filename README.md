# easy_encoding

[![Build Status](https://travis-ci.org/floor114/easy_encoding.svg?branch=master)](https://travis-ci.org/floor114/easy_encoding)

Easy encoding encoding is a tool that allows you to encode and decode data via:
* Huffman encoding.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'easy_encoding'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install easy_encoding
    
## Configuration
You can configure symbol for left and right node of tree.
```ruby
EasyEncoding.configure do |config|
  config.right_node_symbol = 0
  config.left_node_symbol = 1
end
```

## Usage

#### Huffman coding

Using with string:
```ruby
huffman = EasyEncoding::Huffman.new('code')
huffman.frequencies            #=> {:e=>0.25, :d=>0.25, :o=>0.25, :c=>0.25}
huffman.char_codes             #=> {:c=>"00", :o=>"01", :d=>"10", :e=>"11"}
```
Using with frequencies:
```ruby
huffman = EasyEncoding::Huffman.new({ x7: 0.42, x3: 0.28, x5: 0.1, x6: 0.1, x4: 0.05, x2: 0.03, x1: 0.02 })
huffman.frequencies            #=> {:x7=>0.42, :x3=>0.28, :x6=>0.1, :x5=>0.1, :x4=>0.05, :x2=>0.03, :x1=>0.02}
huffman.char_codes             #=> {:x7=>"1", :x3=>"01", :x5=>"0000", :x6=>"0001", :x4=>"0011", :x2=>"00100", :x1=>"00101"}
```

## Contributing

See [CONTRIBUTING.md](https://github.com/floor114/easy_encoding/blob/master/CONTRIBUTING.md).

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

