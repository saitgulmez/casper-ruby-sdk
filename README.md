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
# There are two options to install casper_network

# Option 1:
# Install casper_network that is available in the https://guides.rubygems.org/
gem install casper_network

# Option 2:
git clone git@github.com:saitgulmez/casper-ruby-sdk.git
cd casper-ruby-sdk
# It automatically installs all the required gems located in the Gemfile
bundle install
# Install casper_network gem from repository
# casper_network-X.Y.Z.gem will be generated after running below command
gem build casper_network.gemspec
# (X, Y, Z depends on s.version described in the casper_network.gemspec)
gem install casper_network-X.Y.Z.gem
```

## How to build
```bash
gem build casper_network.gemspec
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
rdoc lib/casper_network.rb
```

## Usage examples
### Get 5 peer IP addresses randomly
```ruby
require 'casper_network'

# In order to interact with casper network we should give a valid ip address to the constructor
node_ip_address = "85.114.132.129" # IP is taken from "testnet"
client = CasperClient.new(node_ip_address)

# Select 5 peers randomly from the network
if (IPAddress.valid? node_ip_address)
  peers = client.info_get_peers.sample(5)


  # Store ip addresses of these peers into an array
  ips = []
  peers.select do |item|
    ip = item["address"]
    ips << ip[0, ip.index(':')]
  end

  # Print
  clients = []
  ips.each do |ip_address|
    # Create a client object for each iteration
    client = CasperClient.new(ip_address)
    clients.push(client)
  end

  clients.each do |client|
    puts client.info_get_peers
    puts client.chain_get_StateRootHash
    puts "**********************************************************"
  end
end
```