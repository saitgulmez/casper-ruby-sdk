# Casper Ruby SDK
The Ruby SDK enables developers to interact with the Casper Network.

## Requirements
Click [**```rbenv```**](https://github.com/rbenv/rbenv) or [**```here (Steps: 1, 2, 3)```**](https://www.digitalocean.com/community/tutorials/how-to-install-ruby-on-rails-with-rbenv-on-ubuntu-20-04) to install dependencies.

```bash
# Install bundler
gem install bundler
```
## How to install

```bash
# There are two options to install casper_sdk

# Option 1:
# Install casper_sdk that is available in the https://guides.rubygems.org/
gem install casper_sdk

# Option 2:
git clone git@github.com:saitgulmez/casper-ruby-sdk.git
cd casper-ruby-sdk
# It automatically installs all the required gems located in the Gemfile
bundle install
# Install casper_sdk gem from repository
# casper_sdk-X.Y.Z.gem will be generated after running below command
gem build casper_sdk.gemspec
# (X, Y, Z depends on s.version described in the casper_sdk.gemspec)
gem install casper_sdk-X.Y.Z.gem
```

## How to build
```bash
gem build casper_sdk.gemspec
```

## How to run tests
```bash
# Install RSpec
gem install rspec
# Run the test
rspec spec/client_spec.rb
```

## How to generate docs
```bash
gem install rdoc
# Generate documentation from source code
rdoc lib/casper_sdk.rb
```

## Usage examples
### Get 5 peer IP addresses randomly
```ruby
require 'casper_sdk'

# In order to interact with casper network we should give a valid ip address to the constructor
# One of an ip address available in the network 
node_ip_address = "74.208.245.69"
client = CasperClient.new(node_ip_address)

# Select 5 peers randomly from the network
peers = client.info_get_peers.sample(5)


# Store ip addresses of these peers into an array
ips = []
peers.select do |item|
  ip = item["address"]
  ips << ip[0, ip.index(':')]
end

# Print
ips.each do |ip_address|
  # Create a client object for each iteration
  client = CasperClient.new(ip_address)
  puts client.info_get_peers
  puts client.chain_get_StateRootHash
end
```