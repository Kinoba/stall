source 'https://rubygems.org'

# Declare your gem's dependencies in stall.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

# To use a debugger
# gem 'byebug', group: [:development, :test]

gem 'rails-i18n'
gem 'devise'

# Needed to make para loading work in tests
gem 'redactor-rails', github: 'glyph-fr/redactor-rails'

# gem 'para', path: '~/gems/para'
gem 'para', '1.0.0', git: 'https://github.com/kinoba/para.git', branch: 'redesign'
# gem 'para', '1.0.0', path: 'path/to/para'

group :test do 
  gem 'rails-controller-testing'
end
