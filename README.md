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
rspec spec/mainnet_spec.rb
```
## Mainnet Tests
```bash
git checkout milestone-2
# Run the test
rspec spec/mainnet_spec.rb
# To see the test results in detail
rspec -fd spec/mainnet_spec.rb
```

## How to generate docs
```bash
gem install yard
# Generate documentation from source code
yardoc lib/entity/*.rb
yardoc lib/*.rb
# To see the options
yardoc --help 
```

## Usage examples
### Get 5 peer IP addresses randomly
```ruby
require 'casper_network'

# In order to interact with casper network we should give a valid ip address to the constructor
# node_ip_address = "85.114.132.129" # IP is taken from "testnet"
node_ip_address = "5.161.68.4" # IP is taken from "Mainnet"
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

# block_Hash taken from MainNet
block_hash = "5fdbdf3fa70d37821aa2d1752743e9653befc15e65e40c2655e1ce93a807260f"
# deploy_Hash taken from MainNet
deploy_hash = "52a40996a88523c475c12e5370ff90b0ae4ec051cfaa57cd048c136b1a83319d"
state_root_hash = "7b605ad991c949832fd966495afc3f97a2b8122a1a6afc2610b545a8c07e3456"
item_key = "f870e3cadfde21d7d7686fdf3d1a8413838274d363ca7b27ae71fc9125eb6743"
uref = "uref-0d689e987db7ee5be246282c3a7badf0411e34baeeab8e9d73c1223ae4ad02e5-007"
switch_block_hash = "4696285db1ca6572f425cada612257f85a58a6a4034c09846afe360ba40e5df0"
clients.each do |client|
  puts client.info_get_peers
  puts client.chain_get_StateRootHash(block_hash)
  puts client.chain_get_StateRootHash
  puts client.info_get_deploy(deploy_hash)
  puts client.info_get_status
  puts client.chain_get_block_transfers(block_hash)
  puts client.chain_get_block_transfers
  puts client.chain_get_block(block_hash)
  puts client.chain_get_eraInfo_by_SwitchBlock(switch_block_hash)
  puts client.state_get_item("647C28545316E913969B032Cf506d5D242e0F857061E70Fb3DF55980611ace86", "bid-24b6D5Aabb8F0AC17D272763A405E9CECa9166B75B745Cf200695E172857c2dD", [])
  puts client.state_get_dictionary_item(state_root_hash, item_key, uref)
  state_root_hash = "610e932aef10d3e1fa04940c79a4a2789ee79c17046f1a9b45a2919f3600f3d5"
  uref = "uref-7de5e973b7d70bc2b328814411f2009aafd8dba901cfc2c588ba65088dcd22bb-007"
  puts client.state_get_balance(state_root_hash, uref)
  puts client.state_get_AuctionInfo

end
end
```