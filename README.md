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
bundle exec rspec
# To see the test results in detail
bundle exec rspec -fd
```

## How run each test file individually 
```bash
git checkout main
# Run the test
rspec spec/file_name.rb
# To see the test results in detail
rspec -fd spec/file_name.rb
# Example:
rspec spec/testnet_spec.rb
# To see results in details
rspec -fd spec/testnet_spec.rb
```


## How to generate docs
```bash
gem install yard
# Generate documentation from source code
yardoc lib/**/*.rb lib/*.rb - README.md LICENSE CONTRIBUTING.md SECURITY.md
# To see the options
yardoc --help 
```

## Documentation

The SDK documentation can be found [here](https://www.rubydoc.info/gems/casper_network/1.1.2) in detail.

### Serialization
Casper provides a custom implementation to serialize data structures used by the Casper node to their byte representation.
More information on this custom implementation can be found [here](https://caspernetwork.readthedocs.io/en/latest/implementation/serialization-standard.html).

* [Serialization](https://github.com/saitgulmez/casper-ruby-sdk/blob/main/docs/serialization.md#serialization)
* [Examples](https://github.com/saitgulmez/casper-ruby-sdk/blob/main/docs/serialization.md#examples)

### Key Management
* [CLPublicKey](https://github.com/saitgulmez/casper-ruby-sdk/blob/main/docs/keys.md#public-keys)

### Casper-Ruby-Sdk RPC
* [info_get_peers](https://github.com/saitgulmez/casper-ruby-sdk/blob/main/docs/rpc.md#info_get_peers)
* [chain_get_StateRootHash](https://github.com/saitgulmez/casper-ruby-sdk/blob/main/docs/rpc.md#get-state_root_hash)
* [info_get_deploy](https://github.com/saitgulmez/casper-ruby-sdk/blob/main/docs/rpc.md#get-deploy)
* [info_get_status](https://github.com/saitgulmez/casper-ruby-sdk/blob/main/docs/rpc.md#get-status)
* [chain_get_block_transfers](https://github.com/saitgulmez/casper-ruby-sdk/blob/main/docs/rpc.md#get-block-transfers)
* [chain_get_block](https://github.com/saitgulmez/casper-ruby-sdk/blob/main/docs/rpc.md#get-block-by-hash)
* [chain_get_eraInfo_by_SwitchBlock](https://github.com/saitgulmez/casper-ruby-sdk/blob/main/docs/rpc.md#get-era-summary-by-switch-block-hash)
* [state_get_item](https://github.com/saitgulmez/casper-ruby-sdk/blob/main/docs/rpc.md#get--state-item)
* [state_get_dictionary_item](https://github.com/saitgulmez/casper-ruby-sdk/blob/main/docs/rpc.md#get-dictionary-item)
* [state_get_balance](https://github.com/saitgulmez/casper-ruby-sdk/blob/main/docs/rpc.md#get-account-balance)
* [state_get_AuctionInfo](https://github.com/saitgulmez/casper-ruby-sdk/blob/main/docs/rpc.md#get-auction-state)
* [put_deploy](https://github.com/saitgulmez/casper-ruby-sdk/blob/main/docs/rpc.md#put-deploy)


## Usage examples

## Include 'casper_network' gem into the source file

```ruby
require 'casper_network'
```
## Create a Client

Pass the node ip address to constructor

```ruby
node_ip_address = "5.9.23.55" # IP is taken from "testnet"
client = Casper::CasperClient.new(node_ip_address)
```
## RPC Calls

### Get network peers list

Retrieves the list of connected peers.

```ruby
peers = client.info_get_peers
# Retrieve to the first peer object
peer = peers[0]
# Retrieve to info of the first peer object
node_id = peer[0].get_node_id
address = peer[0].get_address
```

### Get State Root Hash

Retrieves  the state root hash String.

```ruby
state_root_hash = client.chain_get_StateRootHash
```

### Get Deploy

Retrieves a Deploy object from the network.

call parameters :
- deploy hash

```ruby
deploy_hash = "0806cc477a5282574bc5302d7598cd33a09875704c5fef9264d984535c945e31"
deploy =  client.info_get_deploy(deploy_hash)
# Deploy members
hash = Casper::Entity::DeployHash.new(deploy.get_hash)
header = Casper::Entity::DeployHeader.new(deploy.get_header)
payment = deploy.get_payment
session = deploy.get_session
```

### Get Node Status

Retrieves the current status of the node.

```ruby
node_status = client.info_get_status
# Examples of retrieving and printing the members of node status
puts node_status.get_api_version
puts node_status.get_chainspec_name
puts node_status.get_starting_state_root_hash
puts node_status.get_peers
puts node_status.get_last_added_block_info
puts node_status.get_our_public_signing_key
puts node_status.get_round_length
puts node_status.get_next_upgrade
puts node_status.get_build_version
puts node_status.get_uptime
```

### Get BlockTransfers

Retrieve all transfers for a Block from the network

```ruby
# block_Hash taken from Testnet
block_hash = "ff2ad232c3efc22a385fce44df844fc696e904ce8ba78599a576aa68c76889c4"
transfers = client.chain_get_block_transfers(block_hash)
# Examples of accessing and printing the members of each transfer object
transfers.each do |transfer|
  puts transfer.get_deploy_hash
  puts transfer.get_from
  puts transfer.get_to
  puts transfer.get_source
  puts transfer.get_target
  puts transfer.get_amount
  puts transfer.get_gas
  puts transfer.get_id
end
```

### Get Block

Retrieve a Block object from the network

```ruby
block_hash = "ff2ad232c3efc22a385fce44df844fc696e904ce8ba78599a576aa68c76889c4"
block = client.chain_get_block(block_hash)
puts block # => It is an instance of Block
# To retrieve BlockHeader object
block_header =  block.get_header
puts block_header
# To access and print members of the block_header object (block_header is an instance of BlockHeader )
puts block_header.get_parent_hash
puts block_header.get_state_root_hash
puts block_header.get_body_hash
puts block_header.get_random_bit
puts block_header.get_accumulated_seed
puts block_header.get_era_end
puts block_header.get_timestamp
puts block_header.get_era_id
puts block_header.get_height
puts block_header.get_protocol_version

# To retrieve BlockBody object
block_body = block.get_body
# To access and print members of the block_body object (block_body is an instance of BlockBody )
puts block_body
puts block_body.get_proposer
puts block_body.get_deploy_hashes
puts block_body.get_transfer_hashes

# To retrieve an array of BlockProof objects
proofs = block.get_proofs
# To access and print members of the block_proof objects (block_proof is an instance of BlockProof )
puts proofs
# To access and print each proof object and its members
i = 0
proofs.each do |proof|
  puts "proofs[#{i}]: #{proof}"
  puts "public_key: " + proof.get_public_key
  puts "signature: "  + proof.get_signature
  i += 1
end
```

### Get EraInfo By Switch Block

Retrieves an EraSummury object.

```ruby
block_hash = "d2077716e5b8796723c5720237239720f54e6ada54e3357f2c4896f2a51a6d8f"
era_summary = client.chain_get_eraInfo_by_SwitchBlock(block_hash)
puts era_summary # => It is an instance of EraSummary
puts era_summary.get_block_hash
puts era_summary.get_era_id
puts era_summary.get_stored_value # => Retrieve and print the instance of StoredValue
puts era_summary.get_stored_value.get_stored_value
puts era_summary.get_state_root_hash
puts era_summary.get_merkle_proof
```

### Get StateItem

Retrieves a StoredValue object.

```ruby
node_ip_address = "65.108.78.120" # => Taken from the Mainnet
client = Casper::CasperClient.new(node_ip_address)
# Retrieve the stored_value object which is an instance of StoredValue
stored_value = client.state_get_item("647C28545316E913969B032Cf506d5D242e0F857061E70Fb3DF55980611ace86", "bid-24b6D5Aabb8F0AC17D272763A405E9CECa9166B75B745Cf200695E172857c2dD", [])
puts stored_value # => #<Casper::Entity::StoredValue:0x0000000003767a48>
puts stored_value.get_key # => Bid
puts stored_value.get_bid # => Retrieve and print Bid object related data
# or
puts stored_value.get_stored_value # => Retrieve and print Bid object related data
```

### Get DictionaryItem

Retrieves a CLValue object.

```ruby
node_ip_address = "65.108.78.120" # => Taken from Mainnet
client = Casper::CasperClient.new(node_ip_address)
state_root_hash = "7b605ad991c949832fd966495afc3f97a2b8122a1a6afc2610b545a8c07e3456"
item_key = "f870e3cadfde21d7d7686fdf3d1a8413838274d363ca7b27ae71fc9125eb6743"
uref = "uref-0d689e987db7ee5be246282c3a7badf0411e34baeeab8e9d73c1223ae4ad02e5-007"
# Retrieve folowing data from the network and convert it into its proper CLValue 
# {"CLValue"=>{"cl_type"=>"String", "bytes"=>"1a00000068747470733a2f2f636173706572636f6d6d756e6974792e696f", "parsed"=>"https://caspercommunity.io"}}
stored_value = client.state_get_dictionary_item(state_root_hash, item_key, uref)
puts stored_value # => #<CLString:0x0000000002b3c8e0>
puts stored_value.get_cl_type # => String
puts stored_value.get_value # => https://caspercommunity.io
puts CLValueBytesParsers::CLStringBytesParser.to_bytes(stored_value.get_value) # => 1a00000068747470733a2f2f636173706572636f6d6d756e6974792e696f
```

### Get Balance

Retrieves the balances(in motes) of an account

Parameters :

- state root hash
- account uref hash

```ruby
node_ip_address = "65.108.78.120" # => Taken from Mainnet
client = Casper::CasperClient.new(node_ip_address)
state_root_hash = "610e932aef10d3e1fa04940c79a4a2789ee79c17046f1a9b45a2919f3600f3d5"
uref = "uref-7de5e973b7d70bc2b328814411f2009aafd8dba901cfc2c588ba65088dcd22bb-007"
balance = client.state_get_balance(state_root_hash, uref)
puts balance # => 29269647684075  (current balance  9/24/2022)
```

### Get current auction state

Retrieves an AutionState object.

call parameters :
- block hash

```ruby
# block_Hash taken from MainNet
block_hash = "5fdbdf3fa70d37821aa2d1752743e9653befc15e65e40c2655e1ce93a807260f"
node_ip_address = "65.108.78.120" # => Taken from Mainnet
client = Casper::CasperClient.new(node_ip_address)
auction = client.state_get_AuctionInfo
# Retrieve and print an instance of AuctionState entity
puts auction # => #<Casper::Entity::AuctionState:0x0000000003306bc0>
# Retrieve and print state root hash as a String value
puts auction.get_state_root_hash # => "6448b55f1dd7c9ad337f4fd4c77586d7ae30da146e0b340932aba7e7efa9cbcb"
# Retrieve and print block height as an Integer value
puts auction.get_block_height    # => 1128800
# Retrieve and print an array of instances of EraValidor entity
puts auction.get_era_validators # => [#<Casper::Entity::EraValidator:0x0000000002b69980>, #<Casper::Entity::EraValidator:0x0000000002b68940>]
# Retrieve and print an array of instances of Bid entity
puts auction.get_bids # => [#<Casper::Entity::Bid:0x000000000430bcf0>, #<Casper::Entity::Bid:0x000000000430b6d8>....]

# Retrieve and print an instance of BidInfo, which is also the member of bid object
bids = auction.get_bids
bid =  bids[0] # => #<Casper::Entity::Bid:0x0000000003773dc0>
bid_info = bid.get_bid_info # => #<Casper::Entity::BidInfo:0x00000000042cffc0>
# Retrieve and print an array of delegator objects, which are instance of Delegator entity
delegators = bid_info.get_delegators
puts delegators # => [#<Casper::Entity::Delegator:0x000000000396c550>, #<Casper::Entity::Delegator:0x000000000396c500>.....]
# How to access members of one of the above delegator instances
# For instance, access to stake amount at first delegator    
delegator = delegators[0]
stake_amount = delegator.get_staked_amount # => 27871095039894
```


### Example
```bash
# example.rb
# how to execute example.rb
$ ruby example.rb
```

```ruby
# example.rb
require 'casper_network'
# Class-Object Level
# Casper::CasperClient
node_ip_address = "5.9.23.55" # IP is taken from "testnet"
client = Casper::CasperClient.new(node_ip_address)

#********** info_get_peers *********************************#

# Uncomment following lines to see the outputs
# puts client.info_get_peers
# puts client.info_get_peers[0].get_node_id
# puts client.info_get_peers[0].get_address


#********** chain_get_StateRootHash *********************************#
# Uncomment following line to see the outputs
# puts client.chain_get_StateRootHash


#********** info_get_deploy(deploy_hash) *********************************#
deploy_hash = "0806cc477a5282574bc5302d7598cd33a09875704c5fef9264d984535c945e31"
deploy =  client.info_get_deploy(deploy_hash)
# Uncomment following lines to see the outputs
# puts deploy
# hash = Casper::Entity::DeployHash.new(deploy.get_hash)
# puts hash
# header = Casper::Entity::DeployHeader.new(deploy.get_header)
# puts header
# payment = deploy.get_payment
# puts payment
# session = deploy.get_session
# puts session

# approvals = []
# num_of_approvals = deploy.get_approvals.size
# num_of_approvals.times do |i|
#   approvals.push(Casper::Entity::DeployApproval.new(deploy.get_approvals[i]))
# end
# puts approvals[0].get_signer
# puts hash, header, payment, session, approvals

#********** info_get_status *********************************#
node_status = client.info_get_status
# Uncomment following lines to see the outputs
# puts node_status
# puts node_status.get_api_version
# puts node_status.get_chainspec_name
# puts node_status.get_starting_state_root_hash
# puts node_status.get_peers
# puts node_status.get_last_added_block_info
# puts node_status.get_our_public_signing_key
# puts node_status.get_round_length
# puts node_status.get_next_upgrade
# puts node_status.get_build_version
# puts node_status.get_uptime

#********** chain_get_block_transfers(block_hash = "")  *********************************#
# block_Hash taken from Testnet
block_hash = "ff2ad232c3efc22a385fce44df844fc696e904ce8ba78599a576aa68c76889c4"
transfers = client.chain_get_block_transfers(block_hash)
# Uncomment following lines to see the outputs
# puts transfers
# transfers.each do |transfer|
#   puts transfer.get_deploy_hash
#   puts transfer.get_from
#   puts transfer.get_to
#   puts transfer.get_source
#   puts transfer.get_target
#   puts transfer.get_amount
#   puts transfer.get_gas
#   puts transfer.get_id
# end



#**********  chain_get_block(block_hash) *********************************#
block_hash = "ff2ad232c3efc22a385fce44df844fc696e904ce8ba78599a576aa68c76889c4"
block = client.chain_get_block(block_hash)
# Uncomment following lines to see the outputs
# puts block
# To retrieve BlockHeader object
# block_header =  block.get_header
# puts block_header
# To access and print members of the block_header object (block_header is an instance of BlockHeader )
# puts block_header.get_parent_hash
# puts block_header.get_state_root_hash
# puts block_header.get_body_hash
# puts block_header.get_random_bit
# puts block_header.get_accumulated_seed
# puts block_header.get_era_end
# puts block_header.get_timestamp
# puts block_header.get_era_id
# puts block_header.get_height
# puts block_header.get_protocol_version

# To retrieve BlockBody object
# block_body = block.get_body
# To access and print members of the block_body object (block_body is an instance of BlockBody )
# puts block_body
# puts block_body.get_proposer
# puts block_body.get_deploy_hashes
# puts block_body.get_transfer_hashes

 # To retrieve an array of BlockProof objects
# proofs = block.get_proofs
# To access and print members of the block_proof objects (block_proof is an instance of BlockProof )
# puts proofs
# To access and print each proof object and its members
# i = 0
# proofs.each do |proof|
#   puts "proofs[#{i}]: #{proof}"
#   puts "public_key: " + proof.get_public_key
#   puts "signature: "  + proof.get_signature
#   i += 1
# end



#********** chain_get_eraInfo_by_SwitchBlock(block_hash) *********************************#
block_hash = "d2077716e5b8796723c5720237239720f54e6ada54e3357f2c4896f2a51a6d8f"
era_summary = client.chain_get_eraInfo_by_SwitchBlock(block_hash)
# Uncomment following lines to see the outputs
# puts era_summary
# puts era_summary.get_block_hash
# puts era_summary.get_era_id
# puts era_summary.get_stored_value
# puts era_summary.get_stored_value.get_stored_value
# puts era_summary.get_state_root_hash
# puts era_summary.get_merkle_proof
# era_summary.map { |k, v| puts "#{k}" }
# 



#********** state_get_item(state_root_hash, key, path) *********************************#
node_ip_address = "65.108.78.120" # => Taken from Mainnet
client = Casper::CasperClient.new(node_ip_address)
# Retrieve the stored_value object which is an instance of StoredValue
# Uncomment following lines to see the outputs
stored_value = client.state_get_item("647C28545316E913969B032Cf506d5D242e0F857061E70Fb3DF55980611ace86", "bid-24b6D5Aabb8F0AC17D272763A405E9CECa9166B75B745Cf200695E172857c2dD", [])
# puts stored_value # => #<Casper::Entity::StoredValue:0x0000000003767a48>
# puts stored_value.get_key # => Bid
# puts stored_value.get_bid # => Retrieve and print Bid object related data
# # or
# puts stored_value.get_stored_value # => Retrieve and print Bid object related data




#********** state_get_dictionary_item(state_root_hash, item_key, uref) *********************************#
node_ip_address = "65.108.78.120" # => Taken from Mainnet
client = Casper::CasperClient.new(node_ip_address)
state_root_hash = "7b605ad991c949832fd966495afc3f97a2b8122a1a6afc2610b545a8c07e3456"
item_key = "f870e3cadfde21d7d7686fdf3d1a8413838274d363ca7b27ae71fc9125eb6743"
uref = "uref-0d689e987db7ee5be246282c3a7badf0411e34baeeab8e9d73c1223ae4ad02e5-007"
# # Retrieve folowing data from the network and convert it into its proper CLValue 
# # {"CLValue"=>{"cl_type"=>"String", "bytes"=>"1a00000068747470733a2f2f636173706572636f6d6d756e6974792e696f", "parsed"=>"https://caspercommunity.io"}}

# Uncomment following lines to see the outputs
# stored_value = client.state_get_dictionary_item(state_root_hash, item_key, uref)
# puts stored_value # => #<CLString:0x0000000002b3c8e0>
# puts stored_value.get_cl_type # => String
# puts stored_value.get_value # => https://caspercommunity.io
# puts CLValueBytesParsers::CLStringBytesParser.to_bytes(stored_value.get_value) # => 1a00000068747470733a2f2f636173706572636f6d6d756e6974792e696f



#********** state_get_balance(state_root_hash, balance_uref) *********************************#
node_ip_address = "65.108.78.120" # => Taken from Mainnet
client = Casper::CasperClient.new(node_ip_address)
state_root_hash = "610e932aef10d3e1fa04940c79a4a2789ee79c17046f1a9b45a2919f3600f3d5"
uref = "uref-7de5e973b7d70bc2b328814411f2009aafd8dba901cfc2c588ba65088dcd22bb-007"

# Uncomment following lines to see the outputs
# balance = client.state_get_balance(state_root_hash, uref)
# puts balance # => 29269647684075  (current balance  9/24/2022)


#********** state_get_AuctionInfo *********************************#
# block_Hash taken from MainNet
block_hash = "5fdbdf3fa70d37821aa2d1752743e9653befc15e65e40c2655e1ce93a807260f"
node_ip_address = "65.108.78.120" # => Taken from Mainnet
client = Casper::CasperClient.new(node_ip_address)

# Uncomment following lines to see the outputs
# auction = client.state_get_AuctionInfo
# Retrieve and print an instance of AuctionState entity
# puts auction # => #<Casper::Entity::AuctionState:0x0000000003306bc0>
# Retrieve and print state root hash as a String value
# puts auction.get_state_root_hash # => "6448b55f1dd7c9ad337f4fd4c77586d7ae30da146e0b340932aba7e7efa9cbcb"
# Retrieve and print block height as an Integer value
# puts auction.get_block_height    # => 1128800
# Retrieve and print an array of instances of EraValidor entity
# puts auction.get_era_validators # => [#<Casper::Entity::EraValidator:0x0000000002b69980>, #<Casper::Entity::EraValidator:0x0000000002b68940>]
# Retrieve and print an array of instances of Bid entity
# puts auction.get_bids # => [#<Casper::Entity::Bid:0x000000000430bcf0>, #<Casper::Entity::Bid:0x000000000430b6d8>....]

# Retrieve and print an instance of BidInfo, which is also the member of bid object
# bids = auction.get_bids
# bid =  bids[0] # => #<Casper::Entity::Bid:0x0000000003773dc0>
# bid_info = bid.get_bid_info # => #<Casper::Entity::BidInfo:0x00000000042cffc0>
# Retrieve and print an array of delegator objects, which are instance of Delegator entity
# delegators = bid_info.get_delegators
# puts delegators # => [#<Casper::Entity::Delegator:0x000000000396c550>, #<Casper::Entity::Delegator:0x000000000396c500>.....]
# How to access members of one of the above delegator instances
# For instance, access to stake amount at first delegator    
# delegator = delegators[0]
# stake_amount = delegator.get_staked_amount # => 27871095039894
```