# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'required_query_attributes/version'

Gem::Specification.new do |spec|
  spec.name          = 'required_query_attributes'
  spec.version       = RequiredQueryAttributes::VERSION
  spec.authors       = ['Marco Costa']
  spec.email         = ['marco@marcotc.com']
  spec.license = "MIT"

  spec.summary       = 'Enforce presence of specific columns in ActiveRecord queries.'
  spec.description   = <<~DESC
    Enforces the presence of specific columns in SELECT queries. Useful when you have
    performance restrictions when specific columns are not included in your WHERE clauses.
    Indexed columns and partition keys are common examples of such columns.
  DESC
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
  spec.add_development_dependency 'bundler-audit', '~> 0'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '0.49.1' # Temporarily necessary to avoid breaking ws-style
  spec.add_development_dependency 'sqlite3', '~> 1'
  spec.add_development_dependency 'ws-style', '~> 0'
end
