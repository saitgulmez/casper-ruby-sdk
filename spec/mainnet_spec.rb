# mainnet_spec.rb
require './lib/casper_network.rb'

# Ip Address taken from Mainnet
client = CasperClient.new("5.161.68.4")
describe CasperClient do
  # **********************************************************************************************
  # Test info_get_peers()
  describe "#info_get_peers" do
    it "returns peers array." do
      # Check whether ıt is an array or not
      expect(client.info_get_peers).to be_an(Array)
      # Check the length of the peers array 
      expect(client.info_get_peers.length).to be > 0
    end
  end  

  # **********************************************************************************************
  # Test chain_get_StateRootHash() 
  describe "#chain_get_StateRootHash" do
    it "returns current state_root_hash." do
      # Check whether its type is string or not
      expect(client.chain_get_StateRootHash).to be_an(String)
    end
  end  

# **********************************************************************************************
# block_Hash taken from MainNet
block_hash = "5fdbdf3fa70d37821aa2d1752743e9653befc15e65e40c2655e1ce93a807260f"
# deploy_Hash taken from MainNet
deploy_hash = "52a40996a88523c475c12e5370ff90b0ae4ec051cfaa57cd048c136b1a83319d"
state_root_hash = "7b605ad991c949832fd966495afc3f97a2b8122a1a6afc2610b545a8c07e3456"
item_key = "f870e3cadfde21d7d7686fdf3d1a8413838274d363ca7b27ae71fc9125eb6743"
uref = "uref-0d689e987db7ee5be246282c3a7badf0411e34baeeab8e9d73c1223ae4ad02e5-007"

  # Test info_get_deploy(deploy_hash)
  describe "#info_get_deploy" do 
    it "returns Deploy using a deploy_hash parameter" do
      deploy = client.info_get_deploy(deploy_hash)
      deploy.deep_symbolize_keys!
      expect(deploy).to be_a(Hash)                # passes if objects are the same types
      hash_value = deploy[:hash]
      expect(hash_value).to eql(deploy_hash)      # passes if hash_value.eql?(deploy_hash)
      # expect(hash_value).to be == deploy_hash   # passes if hash_value == deploy_hash
      header = deploy[:header]
      expect(header).to be_truthy                 # passes if header is truthy (not nil or false)
      
      payment = deploy[:payment]
      expect(payment).to be_truthy                # passes if payment is truthy (not nil or false)

      module_bytes = payment[:ModuleBytes]
      key_variable = :ModuleBytes

      session = deploy[:session]
      expect(session).to be_truthy                # passes if session is truthy (not nil or false)
      expect(session).to be_an_instance_of(Hash)  # passes if objects are the same types

      approvals = deploy[:approvals]
      expect(approvals).to be_truthy              # passes if approvals is truthy (not nil or false)
      expect(approvals).to be_an_instance_of(Array) # passes if objects are the same types
    end    
  # }

  end
  # **********************************************************************************************
  # Test info_get_status()
  describe "#info_get_status" do  
    it "returns the current status of the node" do
      node_status = client.info_get_status
      node_status.deep_symbolize_keys!

      chainspec_name = node_status[:chainspec_name]
      expect(chainspec_name).to eql("casper")  # passes if chainspec_name == "casper"

      peers_from_info_get_peers = client.info_get_peers
      peers_from_info_get_status = node_status[:peers]
      expect(peers_from_info_get_status.length).to eql(peers_from_info_get_peers.length)  # passes if peers size are the same in both side

      our_public_signing_key = "0145316b84fee8735291f5a29206e5211c74ab828b0382bb475a4a6e799894ea11"
      expect(node_status[:our_public_signing_key]).to eql(our_public_signing_key) 
    end
  end

  # **********************************************************************************************
  # Test chain_get_block_transfers(block_hash)
  describe "#chain_get_block_transfers(block_hash = "")" do 
    transfers = client.chain_get_block_transfers(block_hash)
    it "returns all transfers for a Block from the network" do  
      expect(transfers).not_to be_empty
      expect(transfers.size).to eql(2)
    end

    it "checks amount of first transaction that is 6000000000000 motes" do 
      first_transaction = transfers[0].deep_symbolize_keys!
      first_transfer_amount = 6000000000000
      expect(first_transaction[:amount].to_i).to eql(first_transfer_amount)
    end

    it "checks amount of second transaction that is 3997300000000 motes" do 
      second_transaction = transfers[1].deep_symbolize_keys!
      second_transfer_amount = 3997300000000
      expect(second_transaction[:amount].to_i).to eql(second_transfer_amount)
    end
  end

  # **********************************************************************************************
  # Test chain_get_block(block_hash)
  describe "#chain_get_block(block_hash)" do  
    block_hash = "5fdbdf3fa70d37821aa2d1752743e9653befc15e65e40c2655e1ce93a807260f"
    block = client.chain_get_block(block_hash)
    block.deep_symbolize_keys!
    it "returns a Block from the network" do  
    
    end

    it "is equal to the block hash" do  
      expect(block[:hash]).to eq(block_hash)   
    end

    it "includes random_bit key" do 
      expect(block[:header]).to have_key(:random_bit)
    end

    it "includes deploy_hashes key" do 
      expect(block[:body]).to have_key(:deploy_hashes)
    end

    it "includes public_key and signature keys" do 
      expect(block[:proofs][0]).to have_key(:public_key)
      expect(block[:proofs][0]).to have_key(:signature)
    end
    

  end

  # **********************************************************************************************
  # Test chain_get_eraInfo_by_SwitchBlock(block_hash)
  describe "#chain_get_eraInfo_by_SwitchBlock(block_hash)" do 
    it "returns an EraInfo from the network" do 
    end
    switch_block_hash = "4696285db1ca6572f425cada612257f85a58a6a4034c09846afe360ba40e5df0"
    era_summary = client.chain_get_eraInfo_by_SwitchBlock(switch_block_hash)
    era_summary.deep_symbolize_keys!

    era_id = 3663
    it "checks whether era_ids are equal or not" do 
      expect(era_summary[:era_id]).to eql(era_id)
    end
   
    state_root_hash = "4f9929288b885bb4eae3c27aaf13c974e1fc79eb12be5c6064e316e5797ca4ec"
    it "checks whether state_root_hashes are equal or not" do 
      expect(era_summary[:state_root_hash]).to eql(state_root_hash)
    end
  end

  # **********************************************************************************************
  # Test state_get_item(state_root_hash, key, path)
  describe "#state_get_item(state_root_hash, key, path)" do 
    it "returns a stored value from the network" do 
    end
    stored_value = client.state_get_item("647C28545316E913969B032Cf506d5D242e0F857061E70Fb3DF55980611ace86", "bid-24b6D5Aabb8F0AC17D272763A405E9CECa9166B75B745Cf200695E172857c2dD", [])
    stored_value.deep_symbolize_keys!

    validator_public_key = "012bac1d0ff9240ff0b7b06d555815640497861619ca12583ddef434885416e69b"
    stored_value[:Bid][:validator_public_key]
   
    it "checks validator_public_key equality" do  
      expect(stored_value[:Bid][:validator_public_key]).to eql(validator_public_key)
    end

    staked_amount = 208330980103513
    it "checks staked_amount which is 208330980103513" do 
      expect(stored_value[:Bid][:staked_amount].to_i).to eql(208330980103513)
    end
   
    it "includes initial_release_timestamp_millis keys" do  
      expect(stored_value[:Bid][:vesting_schedule]).to have_key(:initial_release_timestamp_millis)
    end

  end

  # **********************************************************************************************
  # Test state_get_dictionary_item(state_root_hash, item_key, uref)
  describe "#state_get_dictionary_item(state_root_hash, item_key, uref)" do 
    stored_value = client.state_get_dictionary_item("d5811c438982f231a9152011c0f6ce9ae9c716e8075a6edec8390f10072ecd29","f870e3cadfde21d7d7686fdf3d1a8413838274d363ca7b27ae71fc9125eb6743", "uref-0d689e987db7ee5be246282c3a7badf0411e34baeeab8e9d73c1223ae4ad02e5-007")
    stored_value.deep_symbolize_keys!
    # puts stored_value[:CLValue]
    it "checks that CLValue should not be nil" do  
      expect(stored_value[:CLValue]).to be_truthy
    end

    it "checks that cl_type should equal to String" do  
      expect(stored_value[:CLValue][:cl_type]).to eql("String")
    end

    it "checks that CLValue parsed equals to \"https://caspercommunity.io\"" do  
      expect(stored_value[:CLValue][:parsed]).to eql("https://caspercommunity.io")
    end

  end

  # **********************************************************************************************
  # Test state_get_balance(state_root_hash, balance_uref)
  describe "#state_get_balance(state_root_hash, balance_uref)" do 
    balance = client.state_get_balance("610e932aef10d3e1fa04940c79a4a2789ee79c17046f1a9b45a2919f3600f3d5", "uref-7de5e973b7d70bc2b328814411f2009aafd8dba901cfc2c588ba65088dcd22bb-007")

    it "is equal to 29269647684075" do  
      expect(balance.to_i).to eql(29269647684075)
    end
  end

  # **********************************************************************************************
  # Test state_get_AuctionInfo
  describe "#state_get_AuctionInfo" do
    auction_state = client.state_get_AuctionInfo  
    auction_state.deep_symbolize_keys!
    it "checks state root hash equality and they should be equal" do  
      expect(auction_state[:state_root_hash]).to eql(client.chain_get_StateRootHash)
    end

    it "checks that era_validators is not empty" do
      expect(auction_state[:era_validators]).not_to be_empty
    end
  end
  
end