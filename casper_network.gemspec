# casper_network.gemspec
$:.unshift(File.dirname(__FILE__) + '/lib/')
$:.unshift(File.dirname(__FILE__) + '/lib/**')
$:.unshift(File.dirname(__FILE__) + '/lib/**/*.rb')
require 'version'
Gem::Specification.new do |s|
  s.name        = 'casper_network'           
  # s.version     = '0.2.1'
  s.version = CasperNetworkSDK::VERSION
  s.summary     = "Casper Ruby SDK "
  s.description = "Ruby gem enables developers to interact with the Casper Network."
  s.authors     = ["Mehmet Sait Gülmez"]
  s.email       = 'cenggulmez.65@gmail.com'
  s.homepage    = 'https://github.com/saitgulmez/casper-ruby-sdk.git'
  s.license      = 'Apache-2.0'
  s.require_path = "lib"
  s.files = %w[
    LICENSE
    README.md
    SECURITY.md
    CONTRIBUTING.md
  ] + Dir['lib/**/*.rb']
  # puts s.files
  s.test_files = Dir['spec/*.rb']
end