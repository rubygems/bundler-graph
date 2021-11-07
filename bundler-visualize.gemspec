# frozen_string_literal: true

require_relative "lib/bundler/visualize/version"

Gem::Specification.new do |spec|
  spec.name          = "bundler-visualize"
  spec.version       = Bundler::Visualize::VERSION
  spec.authors       = ["Hiroshi SHIBATA"]
  spec.email         = ["hsbt@ruby-lang.org"]

  spec.summary       = "Generate a visual representation of your gem dependencies"
  spec.description   = "A bundler plugin that generates a visual representation of your gem dependencies."
  spec.homepage      = "https://github.com/rubygems/bundler-viz"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 2.4.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "https://github.com/rubygems/bundler-viz/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
