$:.push File.expand_path("../lib", __FILE__)
require "acts_as_indexable/version"

Gem::Specification.new do |s|
  s.name          = "acts_as_indexable"
  s.version       = ActsAsIndexable::VERSION
  s.authors       = ["Taylor C. MacDonald"]
  s.email         = ["tcmacdonald@gmail.com"]
  s.homepage      = "https://github.com/tcmacdonald/acts_as_indexable"
  s.summary       = "Utilities for building and extending table views in your Rails application."
  s.description   = "ActsAsIndexable is a Rails engine that provides a configurable DSL for rendering tables in index views of your application. It works with any collection of enumerable objects, ActiveRecord or otherwise."
  s.license       = "MIT"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ['lib','app']

  s.add_runtime_dependency 'rails', '~> 4.2', '>= 4.2.3'

  s.add_development_dependency 'sqlite3', '~> 1.3', '>= 1.3.11'
  s.add_development_dependency 'rspec-rails', '~> 3.4', '>= 3.4.0'
  s.add_development_dependency 'shoulda-matchers', '~> 3.0', '>= 3.0.1'
  s.add_development_dependency 'database_cleaner', '~> 1.4', '>= 1.5.1'
  s.add_development_dependency 'guard-rspec', '~> 4.6', '>= 4.6.4'
  s.add_development_dependency 'launchy', '~> 2.4', '>= 2.4.3'
  s.add_development_dependency 'capybara', '~> 2.5', '>= 2.5.0'
  s.add_development_dependency 'capybara-webkit', '~> 1.7', '>= 1.7.1'
  s.add_development_dependency 'factory_girl_rails', '~> 4.5', '>= 4.5.0'
  s.add_development_dependency 'pry', '~> 0.10', '>= 0.10.3'

end
