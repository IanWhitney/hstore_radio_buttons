# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hstore_radio_buttons/version'

Gem::Specification.new do |spec|
  spec.name          = "hstore_radio_buttons"
  spec.version       = HstoreRadioButtons::VERSION
  spec.authors       = ["Ian Whitney"]
  spec.email         = ["ian@ianwhitney.com"]
  spec.description   = %q{Works with postgres's hstore data type and Rails to let you display/store a collection of radio buttons in an hstore field}
  spec.summary       = %q{Define a set of radio buttons for a model and then save the perisisted data for these buttons in an hstore field. Good for data that you want to persist, but that isn't important enough for its own field in the model.}
  spec.homepage      = "https://github.com/IanWhitney/hstore_radio_buttons"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'activerecord', '~> 3.0'
  spec.add_dependency 'activesupport', '~> 3.0'

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
