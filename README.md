# Casper Ruby SDK
The Ruby SDK enables developers to interact with the Casper Network.

## Requirements
Click [rbenv](https://github.com/rbenv/rbenv) or [here (Steps: 1, 2, 3)](https://www.digitalocean.com/community/tutorials/how-to-install-ruby-on-rails-with-rbenv-on-ubuntu-20-04) to install dependencies.
```bash
ruby -v
# ruby 3.0.2
```
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
rspec spec/testnet_spec.rb
rspec spec/mainnet_spec.rb
```

## Testnet Tests
```bash
git checkout main
# Run the test
rspec spec/testnet_spec.rb
# To see the test results in detail
rspec -fd spec/testnet_spec.rb
# Test for cltypes
rspec -fd spec/cl_types_spec.rb
```

## Mainnet Tests
```bash
# Run the test
rspec spec/mainnet_spec.rb
# To see the test results in detail
rspec -fd spec/mainnet_spec.rb
```

## How to generate docs
```bash
gem install yard
# Generate documentation from source code
yardoc lib/**/*.rb lib/*.rb - README.md LICENSE CONTRIBUTING.md SECURITY.md
# To see the options
yardoc --help 
```

## Usage examples
### Get 5 peer IP addresses randomly
```ruby
require 'casper_network'

# In order to interact with casper network we should give a valid ip address to the constructor

# if it does not work, please choose another node ip address from the Testnet
# IP is taken from "Testnet"
node_ip_address = "85.114.132.129" 
# block_Hash taken from Testnet
block_hash = "71e19e2e9629c716dc9578066cfeceace559d32fe51b08245ddd4d218f8c18da"
# deploy_Hash taken from Testnet
deploy_hash = "d3e0a1bd85ee74916e096cf4b18df391ada414d0915aeb865eff0ba75f04c3d8"
state_root_hash = "2a62440a1e1e57bff71344aac8a7de169f6dd08d29cffe83b2fb5d6648971855"
item_key = "f870e3cadfde21d7d7686fdf3d1a8413838274d363ca7b27ae71fc9125eb6743"
uref = "uref-9199d08ff4ca4d52cd7a05ba0d2694204b7ebff963fec1c216f81bf654e0e59f-007"
switch_block_hash = "9e30104581a492f5c6faad4cdfb098311e3bf0e93897ebbfb47c3df62f5e6375"


# Uncomment following lines to test on Mainnet 
# if it does not work, please choose another node ip address from the Mainnet
# IP is taken from "Mainnet"
# node_ip_address = "65.108.78.12" 
# block_Hash taken from MainNet
# block_hash = "5fdbdf3fa70d37821aa2d1752743e9653befc15e65e40c2655e1ce93a807260f"
# # deploy_Hash taken from MainNet
# deploy_hash = "52a40996a88523c475c12e5370ff90b0ae4ec051cfaa57cd048c136b1a83319d"
# state_root_hash = "7b605ad991c949832fd966495afc3f97a2b8122a1a6afc2610b545a8c07e3456"
# item_key = "f870e3cadfde21d7d7686fdf3d1a8413838274d363ca7b27ae71fc9125eb6743"
# uref = "uref-0d689e987db7ee5be246282c3a7badf0411e34baeeab8e9d73c1223ae4ad02e5-007"
# switch_block_hash = "4696285db1ca6572f425cada612257f85a58a6a4034c09846afe360ba40e5df0"

if (IPAddress.valid? node_ip_address)
  client = Casper::CasperClient.new(node_ip_address)
  peers = client.info_get_peers.sample(5)
  puts "node_id and address of five randomly selected 5 peers:"
  puts peers

  # Store ip addresses of these peers into an array
  ips = []
  peers.select do |item|
    ip = item["address"]
    ips << ip[0, ip.index(':')]
  end

  clients = []
  puts "Randomly selected 5 peers ip addresses:"
  ips.each do |ip_address|
    # Create a client object for each iteration
    puts ip_address
    client = CasperClient.new(ip_address)
    clients.push(client)
  end


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
else
  puts "Invalid IP address"
end
```
- [Testnet](https://testnet.cspr.live/tools/peers),  [Mainnet](https://cspr.live/tools/peers)
- [doc](https://www.rubydoc.info/gems/casper_network/0.2.1)


## TODO
- [ ] Ruby version of CLType primitives
- [ ] Ruby version for Casper domain-specific objects
- [ ] Serialization of Casper domain-specific objects
- [ ] ED25519/SECP256K1 key pairs  Wrappers implemented
- [ ] PutDeploy call implemented and tested
- [ ] SDK calls will return Casper domain-specific objects