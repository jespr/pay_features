# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'pay_features/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = 'pay_features'
  spec.version     = PayFeatures::VERSION
  spec.authors     = ['Jesper Christiansen']
  spec.email       = ['hi@jespr.com']
  spec.homepage    = 'https://github.com/jespr/pay_features'
  spec.summary     = 'Specify features for your subscription plans and check that the user has access to those'
  spec.description = 'Specify features for your subscription plans and check that the user has access to those'
  spec.license     = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  spec.add_dependency 'rails', '~> 6.0.0'

  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'sqlite3'
end
