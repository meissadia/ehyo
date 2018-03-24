
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "ehyo/version"

Gem::Specification.new do |spec|
  spec.name          = "ehyo"
  spec.version       = Ehyo::VERSION
  spec.authors       = ["Meissa Dia"]
  spec.email         = ["meissadia@gmail.com"]

  spec.summary       = %q{Macros for Git, Rails, Heroku Developers}
  spec.description   = %q{A collection of macros to simplify developing with Git, Rails, and Heroku from the command line.}
  spec.homepage      = "http://meissadia.surge.sh"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "bin"
  spec.executables   = ['ehyo']
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_dependency "commander", "~> 4.4.4"
end
