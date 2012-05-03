# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "time_date_helpers/version"

Gem::Specification.new do |s|
  s.name        = "time_date_helpers"
  s.version     = TimeDateHelpers::VERSION
  s.authors     = ["Klingon Code Warrior"]
  s.email       = ["profh@cmu.edu"]
  s.homepage    = ""
  s.summary     = %q{A series of helpers to deal with time and date issues in Rails.}
  s.description = %q{The initial version has only a few date and time helpers and was created primarily for teaching purposes (how to create gems), but does have some value. I will try to get back to this gem and add more methods as time allows.}

  s.rubyforge_project = "time_date_helpers"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "chronic"
  s.add_runtime_dependency "chronic"
end
