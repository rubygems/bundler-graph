# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = "bundler-graph"
  spec.version       = "0.2.1"
  spec.authors       = ["Hiroshi SHIBATA"]
  spec.email         = ["hsbt@ruby-lang.org"]

  spec.summary       = "Generates a visual dependency graph for your Gemfile"
  spec.description   = "`graph` generates a PNG file of the current `Gemfile(5)` as a dependency graph."
  spec.homepage      = "https://github.com/rubygems/bundler-graph"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 2.4.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
