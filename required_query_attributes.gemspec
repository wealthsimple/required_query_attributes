# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'required_query_attributes/version'

Gem::Specification.new do |spec|
  spec.name          = 'required_query_attributes'
  spec.version       = RequiredQueryAttributes::VERSION
  spec.authors       = ['Marco Costa']
  spec.email         = ['marco@marcotc.com']

  spec.summary       = 'PLACEHOLDER'
  spec.description   = 'PLACEHOLDER'
  spec.homepage      = 'https://github.com/wealthsimple/required_query_attributes'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.4'

  spec.add_dependency 'activerecord', '~> 5'

  spec.add_development_dependency 'bundler', '~> 1.15'
  spec.add_development_dependency 'bundler-audit'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'ws-style'
end
