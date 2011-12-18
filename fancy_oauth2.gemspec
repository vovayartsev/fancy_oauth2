# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "fancy_oauth2/version"

Gem::Specification.new do |s|
  s.name        = "fancy_oauth2"
  s.version     = FancyOauth2::VERSION
  s.authors     = ["Vladimir Yartsev"]
  s.email       = ["vovayartsev@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Put oauth2 negotiation into a fancybox}
  s.description = %q{Adds controller/views/styles/js to put all your oauth2 negotiation into a fancybox and }

  #s.rubyforge_project = "fancy_oauth2"

  s.files         = Dir['lib/**/*.*'] + Dir['config/**/*.*'] + Dir['app/**/*.*']
  #s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  #s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib", "app/helpers", "app/controllers"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  s.add_development_dependency "rails", "~> 3.1.0"
  s.add_runtime_dependency "rails", "~> 3.1.0"
end
