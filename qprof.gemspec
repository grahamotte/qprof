# frozen_string_literal: true

require_relative 'lib/qprof/version'

Gem::Specification.new do |spec|
  spec.name          = 'qprof'
  spec.version       = QProf::VERSION
  spec.platform      = Gem::Platform::RUBY
  spec.author        = 'graham otte'
  spec.email         = 'go@grahamotte.com'
  spec.description   = 'quick and dirty ruby flamegraphs'
  spec.summary       = spec.description
  spec.homepage      = 'https://github.com/grahamotte/qprof'
  spec.license       = 'MIT'
  spec.files         = Dir['**/*'].select { |f| f[%r{^(lib/|.*gemspec)}] }
  spec.require_paths = ['lib']
  spec.add_dependency('securerandom')
  spec.add_dependency('benchmark')
  spec.add_dependency('ruby-prof')
  spec.add_dependency('ruby-prof-flamegraph')
  spec.add_dependency('launchy')
end
