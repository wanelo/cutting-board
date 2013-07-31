# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cutting-board/version'

Gem::Specification.new do |gem|
  gem.name          = 'cutting-board'
  gem.version       = CuttingBoard::VERSION
  gem.authors       = ['Eric Saxby']
  gem.email         = %w(sax@wanelo.com)
  gem.description   = %q(cutting-board is a chef and capistrano plugin that assists deployment by bridging the two. Using knife search, cutting-board will create local caches of server lists in yml format, which capistrano can then use during deployment.)
  gem.summary       = %q(bridge the gap between chef and capistrano)
  gem.homepage      = 'https://github.com/wanelo/cutting-board'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = %w(lib)
end
