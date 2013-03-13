# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ec2-elastic-autofailover/version'

Gem::Specification.new do |gem|
  gem.name           = "ec2-elastic-autofailover"
  gem.version        = Ec2::Elastic::Autofailover::VERSION
  gem.authors        = ["rajofchennai"]
  gem.email          = ["rajofchennai@yahoo.com"]
  gem.description    = %q{Pings a URL(elastic) if it goes down it shifts elastic ip to another instance}
  gem.summary        = "Automatic transfer of elastic ip in case of failure"
  gem.homepage       = ""
  gem.add_dependency "eventmachine", "~> 1.0.3"
  gem.add_dependency "rest-client", "~> 1.6.7"
  gem.add_dependency "amazon-ec2"
  gem.add_development_dependency "rspec"
  gem.files          = `git ls-files`.split($/)
  gem.executables    = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files     = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths  = ["lib"]
end
