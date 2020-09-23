require_relative 'lib/should_send_same_site_none/version'

Gem::Specification.new do |spec|
  spec.name          = "should_send_same_site_none"
  spec.version       = ShouldSendSameSiteNone::VERSION
  spec.authors       = ["Sergio"]
  spec.email         = ["sergiomorenoalbert@gmail.com"]

  spec.summary       = %q{A simple utility to detect incompatible user agents for `SameSite=None` cookie attribute}
  spec.description   = %q{A simple utility to detect incompatible user agents for `SameSite=None` cookie attribute}
  spec.homepage      = "https://github.com/semoal/should_send_same_site_none"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "http://mygemserver.com"

  spec.metadata["homepage_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
