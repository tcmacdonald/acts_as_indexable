$:.push File.expand_path("../lib", __FILE__)
require "acts_as_indexable/version"

Gem::Specification.new do |s|
  s.name          = "acts_as_indexable"
  s.version       = ActsAsIndexable::VERSION
  s.authors       = ["Taylor C. MacDonald"]
  s.email         = ["tcmacdonald@gmail.com"]
  s.homepage      = "https://github.com/tcmacdonald/acts_as_indexable"
  s.summary       = "Provides utilities for building and extending index views."
  s.description   = s.summary
  s.license       = "MIT"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ['lib','app']

  s.add_dependency "rails", "~> 4.2.3"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'shoulda-matchers'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'guard-rspec'
  s.add_development_dependency 'launchy'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'capybara-webkit'
  s.add_development_dependency 'factory_girl_rails'
  s.add_development_dependency 'pry'

end
