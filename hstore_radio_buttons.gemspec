# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hstore_radio_buttons/version'

Gem::Specification.new do |gem|
  gem.name          = "hstore_radio_buttons"
  gem.version       = HstoreRadioButtons::VERSION
  gem.authors       = ["Ian Whitney"]
  gem.email         = ["ian@ianwhitney.com"]
  gem.description   = %q{Works with postgres's hstore data type and Rails to let you display/store a collection of radio buttons in an hstore field}
  gem.summary       = %q{Define a set of radio buttons for a model and then save the perisisted data for these buttons in an hstore field. Good for data that you want to persist, but that isn't important enough for its own field in the model.}
  gem.homepage      = "https://github.com/IanWhitney/hstore_radio_buttons"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
