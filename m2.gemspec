# frozen_string_literal: true

require_relative "lib/m2/version"

Gem::Specification.new do |spec|
  spec.name = "m2"
  spec.version = M2::VERSION
  spec.authors = ["awrznc"]
  spec.email = ["awrznc@gmail.com"]

  spec.summary = ""
  spec.description = ""
  spec.homepage = ""
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = ""

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = ""
  spec.metadata["changelog_uri"] = ""

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) || f.start_with?(*%w[.git bin/ lib/ share/])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
