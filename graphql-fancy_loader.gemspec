# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'graphql/fancy_loader/version'

Gem::Specification.new do |spec|
  spec.name          = 'graphql-fancy_loader'
  spec.version       = GraphQL::FancyLoader::VERSION
  spec.authors       = ['Toyhammered', 'Emma Lejeck']
  spec.email         = ['nuck@kitsu.io']

  spec.summary       = 'FancyLoader efficiently batches queries using postgres window functions to allow advanced features such as orders, limits, pagination, and authorization scoping.'
  spec.description   = 'FancyLoader (built on top of the graphql-batch gem) efficiently batches queries using postgres window functions to allow advanced features such as orders, limits, pagination, and authorization scoping. Built on top of Arel, FancyLoader is highly extensible and capable of handling complex sorts (including sorting based on a join) with minimal effort and high performance.'
  spec.homepage      = 'https://github.com/hummingbird-me/graphql-fancy-loader'
  spec.license       = 'Apache-2.0'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/hummingbird-me/graphql-fancy-loader'
  spec.metadata['allowed_push_host'] = 'https://rubygems.org'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'activesupport', '>= 5.0', '< 9.0'
  spec.add_runtime_dependency 'graphql', '>= 1.3', '< 3'
  spec.add_runtime_dependency 'graphql-batch', '>= 0.4.3', '< 1'

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'pry-byebug', '~> 3.10'
  spec.add_development_dependency 'rake', '>= 13.2'
  spec.add_development_dependency 'rspec', '~> 3.13'
  spec.add_development_dependency 'simplecov', '~> 0.22'
  spec.add_development_dependency 'timecop', '~> 0.9'
  # Rails specific stuff
  spec.add_development_dependency 'bootsnap', '~> 1.18'
  spec.add_development_dependency 'database_cleaner', '~> 2.1'
  spec.add_development_dependency 'factory_bot_rails', '~> 6.4'
  spec.add_development_dependency 'listen', '~> 3.9'
  spec.add_development_dependency 'pg', '~> 1.5'
  spec.add_development_dependency 'rails', '8.0'
  spec.add_development_dependency 'rspec-rails', '~> 7.0'
end
