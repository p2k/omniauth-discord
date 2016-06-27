# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'omniauth/discord/version'

Gem::Specification.new do |spec|
  spec.name          = 'omniauth-discord'
  spec.version       = OmniAuth::Discord::VERSION
  spec.authors       = ['Patrick Schneider (p2k)']
  spec.email         = ['patrick.p2k.schneider@gmail.com']
  spec.summary       = 'Discord OAuth2 Strategy for OmniAuth'
  spec.homepage      = 'https://github.com/p2k/omniauth-discord'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'omniauth-oauth2', '~> 1.1'

  spec.add_development_dependency 'bundler', '~> 1.5'
  spec.add_development_dependency 'rake'
end
