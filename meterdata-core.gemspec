# -*- coding: utf-8 -*-

lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'meterdata/version'

Gem::Specification.new do |s|

  s.name        = "meterdata"
  s.version     = Meterdata::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Martin Gamsjaeger']
  s.email       = "gamsnjaga@gmail.com"

  s.homepage    = "http://github.com/snusnu/meterdata"
  s.summary     = "A fistful of code metrics"
  s.description = "Code metrics from Flog, Flay, RCov, Saikuro, Churn, Reek and Roodi"

  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project         = "meterdata"

  s.files      = Dir.glob("{bin,lib}/**/*") + %w(LICENSE README.md TODO.md)
  s.test_files = Dir.glob("{spec}/**/*")

  s.require_path = 'lib'
  s.executables  = ['meterdata']

  s.add_dependency("flay",    [ ">= 1.2.1"   ])
  s.add_dependency("flog",    [ ">= 2.2.0"   ])
  s.add_dependency("rcov",    [ ">= 0.8.3.3" ])
  s.add_dependency("reek",    [ ">=1.2.6"    ])
  s.add_dependency("roodi",   [ ">=2.1.0"    ])
  s.add_dependency("chronic", [ ">= 0.2.3"   ])
  s.add_dependency("churn",   [ ">= 0.0.7"   ])
  s.add_dependency("Saikuro", [ ">= 1.1.0"   ])

  s.add_development_dependency("rspec", ["~> 1.3"])

end
