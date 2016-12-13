$:.push File.expand_path('../lib', __FILE__)

require 'pluckify/version'

Gem::Specification.new do |s|
  s.name        = 'pluckify'
  s.version     = Pluckify::VERSION
  s.authors     = ['Romain de Landesen']
  s.email       = ['rdelandesen@gmail.com']
  s.homepage    = 'https://github.com/rdelandesen/pluckify'
  s.summary     = 'Pluckify allows you to pluck to Hash, OpenStruct or any custom class like presenters'
  s.description = 'Pluckify allows you to pluck to Hash, OpenStruct or any custom class like presenters'
  s.license     = 'MIT'

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency 'activerecord', '>= 4.0.2'
  s.add_dependency 'activesupport', '>= 4.0.2'
end
