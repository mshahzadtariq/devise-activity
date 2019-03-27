$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "devise_activity/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "devise-activity"
  s.version     = DeviseActivity::VERSION
  s.authors     = ["M Shahzad Tariq"]
  s.email       = ["m.shahzad.tariq@hotmail.com"]
  s.homepage    = "http://github.com/mshahzadtariq/devise-activity"
  s.summary     = "Store devise user session and page visiting history with duration and date/time in rails"
  s.description = "Store devise user session and page visiting history with duration and date/time in rails"
  s.license     = "MIT"

  s.files = Dir["{app,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", '>= 3'

  #s.add_development_dependency "sqlite3"
end
