# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "has_magick_title/version"

Gem::Specification.new do |s|
  s.name        = "has_magick_title"
  s.version     = HasMagickTitle::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Spencer Steffen"]
  s.email       = ["spencer@citrusme.com"]
  s.homepage    = "https://github.com/citrus/has_magick_title"
  s.summary     = %q{Automagically creates an image of your rails model's title using magick_title.}
  s.description = %q{Automagically creates an image of your rails model's title using magick_title.}

  s.rubyforge_project = "has_magick_title"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_dependency 'magick_title', '>= 0.1.8'
  
  s.add_development_dependency 'rails',   '>= 3.0.0'
  s.add_development_dependency 'sqlite3', '>= 1.3.3'
  s.add_development_dependency 'shoulda', '2.11.3'
  s.add_development_dependency 'dummier', '0.1.0.rc1'
  
end