lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'easy_encoding/version'

Gem::Specification.new do |spec|
  spec.name          = 'easy_encoding'
  spec.version       = EasyEncoding::VERSION
  spec.authors       = ['Taras Shpachenko']
  spec.email         = ['taras.shpachenko@gmail.com']
  spec.homepage      = 'https://github.com/floor114/easy_encoding'
  spec.summary       = 'Easily encode and decode data.'
  spec.description   = 'Easy encoding is a tool that allows you to encode and decode data.'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.45.0'
end
