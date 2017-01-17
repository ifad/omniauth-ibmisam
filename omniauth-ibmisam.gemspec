$:.push File.expand_path("../lib", __FILE__)

require 'omniauth/ibmisam/version'

Gem::Specification.new do |gem|
  gem.name          = "omniauth-ibmisam"
  gem.version       = OmniAuth::Ibmisam::VERSION
  gem.date          = %q{2017-01-16}
  gem.authors       = ["Thimios Dimopulos"]
  gem.email         = ["e.dimopoulos@ifad.org"]
  gem.summary       = %q{IBM ISAM Strategy for OmniAuth}
  gem.description   = "An omniauth strategy to be used with IBM ISAM."
  gem.homepage      = "https://github.com/ifad/omniauth-ibmisam"
  gem.licenses      = ['MIT']

  gem.require_paths = ["lib"]
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")

  gem.add_dependency 'omniauth', '~> 1.3'

  gem.add_development_dependency "rspec", "~> 3.5"
  gem.add_development_dependency "rack-test", '~> 0.6'
  gem.add_development_dependency "byebug", '~> 9.0'
end
