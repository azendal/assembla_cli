# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "assembla_cli/version"

Gem::Specification.new do |s|
  s.name        = "assembla_cli"
  s.version     = AssemblaCli::VERSION
  s.authors     = ["azendal", "ktlacaelel", "edgarjs"]
  s.email       = ["azendal@gmail.com", "ktlacaelel@gmail.com", "edgar.js@gmail.com"]
  s.homepage    = "https://github.com/azendal/assembla_cli/"
  s.summary     = %q{A CLI to use Assembla for easy usage}
  s.description = %q{A CLI to use Assembla for easy usage}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "ruby-debug"
  s.add_runtime_dependency "hirb"
  s.add_runtime_dependency "hashie"
  s.add_runtime_dependency "httparty"
  s.add_runtime_dependency "isna"
end
