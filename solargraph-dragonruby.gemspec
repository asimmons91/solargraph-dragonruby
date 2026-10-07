# frozen_string_literal: true

require_relative "lib/solargraph/dragonruby/version"

Gem::Specification.new do |spec|
  spec.name = "solargraph-dragonruby"
  spec.version = Solargraph::Dragonruby::VERSION
  spec.authors = ["Austin Simmons"]
  spec.email = ["austin_simmons@fastmail.com"]

  spec.summary = "Solargraph plugin providing DragonRuby Game Toolkit API completion"
  spec.description = "Adds YARD-documented DragonRuby GTK API pins (args, outputs, inputs, $gtk, Geometry, ...) " \
    "to Solargraph so LSP editors get autocomplete, hover and go-to-definition in DragonRuby games."
  spec.homepage = "https://github.com/asimmons91/solargraph-dragonruby"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.2.0"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/main/CHANGELOG.md"

  spec.metadata["rubygems_mfa_required"] = "true"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ Gemfile .gitignore test/ .github/ .standard.yml rakelib/ mise.toml])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Solargraph's convention internals change between minor releases
  # (0.61 removed DocMap), so bump this deliberately after re-running tests.
  spec.add_dependency "solargraph", "~> 0.61.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://guides.rubygems.org/make-your-own-gem/
end
