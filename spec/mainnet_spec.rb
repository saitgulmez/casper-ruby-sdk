# mainnet_spec.rb
require './lib/casper_network.rb'

# Ip Address taken from Mainnet
client = CasperClient.new("5.161.68.4")
# block_Hash taken from MainNet
block_hash = "5fdbdf3fa70d37821aa2d1752743e9653befc15e65e40c2655e1ce93a807260f"
# deploy_Hash taken from MainNet
deploy_hash = "52a40996a88523c475c12e5370ff90b0ae4ec051cfaa57cd048c136b1a83319d"
state_root_hash = "7b605ad991c949832fd966495afc3f97a2b8122a1a6afc2610b545a8c07e3456"
item_key = "f870e3cadfde21d7d7686fdf3d1a8413838274d363ca7b27ae71fc9125eb6743"
uref = "uref-0d689e987db7ee5be246282c3a7badf0411e34baeeab8e9d73c1223ae4ad02e5-007"
describe CasperClient do
  # **********************************************************************************************
  # Test info_get_peers()
  describe "#info_get_peers" do
    peers = client.info_get_peers 
    context "Peers Array" do
      it "passes, peers array is not nil" do 
        expect(peers).to be_truthy
      end
     
      it "passes, peers array is not empty" do 
        expect(peers).not_to be_empty
      end
     
      it "passes, size of both peer arrays are equal" do
        # Check the length of the peers array 
        client2 = CasperClient.new("34.192.231.34")
        other_peers = client2.info_get_peers
        expect(peers.size).to eql(other_peers.size)
      end
     
      it "passes, peers object is a type of Array" do
        # Check whether ıt is an array or not
        expect(client.info_get_peers).to be_an(Array)
        # Check the length of the peers array 
        expect(client.info_get_peers.length).to be > 0
      end

      it "passes, peers member are types of Hash" do
        # Check type of peers elements
        expect(peers[0]).to be_an_instance_of(Hash)
      end
        
      peer = peers[0]
      first_item = peer["node_id"]
      second_item = peer["address"]
      it "passes, peer members are types of String" do
          expect(first_item).to be_an_instance_of(String)
          expect(second_item).to be_an_instance_of(String)
          expect(first_item.length).to eq(14)
      end
      
      it "passes, length of first_item equal #{first_item.length}"  do
          expect(first_item.length).to eq(14)
      end
      
      peer.deep_symbolize_keys!
      it "passes, peer includes node_id key" do
          expect(peer).to have_key(:node_id)
      end

      it "passes, peer includes address key" do
          expect(peer).to have_key(:address)
      end
    end
  end  

  # **********************************************************************************************
  # Test chain_get_StateRootHash 
  describe "#chain_get_StateRootHash" do
    context "Without a block_hash parameter" do 
      current_state_root_hash = client.chain_get_StateRootHash("")
      it "passes,  current state_root_hash is a type of String" do
        expect(current_state_root_hash).to be_an(String)
      end

      it "passes,  current state_root_hash is not nil" do
        expect(current_state_root_hash).to be_truthy
      end

      it "passes,  current state_root_hash is not empty" do
        expect(current_state_root_hash).not_to be_empty
      end

      it "passes,  current state_root_hash is 64 characters long" do
        expect(current_state_root_hash.length).to eq(64)
      end
    end

    context "With a block_hash parameter" do 
      current_state_root_hash = client.chain_get_StateRootHash(state_root_hash)
      it "passes,  current state_root_hash is a type of String" do
        expect(current_state_root_hash).to be_an(String)
      end

      it "passes,  current state_root_hash is not nil" do
        expect(current_state_root_hash).to be_truthy
      end

      it "passes,  current state_root_hash is not empty" do
        expect(current_state_root_hash).not_to be_empty
      end

      it "passes,  current state_root_hash is 64 characters long" do
        expect(current_state_root_hash.length).to eq(64)
      end
    end
  end  
# **********************************************************************************************

  # Test info_get_deploy(deploy_hash)
  describe "#info_get_deploy" do 
    context "When info_get_deploy method is called with deploy hash parameter" do 
        deploy = client.info_get_deploy(deploy_hash)
        deploy.deep_symbolize_keys!
        payment = deploy[:payment]
        session = deploy[:session]
        approvals = deploy[:approvals]
      it "passes, Deploy type is a Hash" do 
        expect(deploy).to be_a(Hash)
      end
     
      it "passes, hash value of Deploy is equal to the deploy_hash value" do 
        hash_value = deploy[:hash]
        expect(hash_value).to eql(deploy_hash)
      end
     
      it "passes, header is not nil" do 
        header = deploy[:header]
        expect(header).to be_truthy
      end
     
      it "passes, payment is not nil" do 
        expect(payment).to be_truthy
      end
     
      it "passes, payment includes ModuleBytes key" do 
        # module_bytes = payment[:ModuleBytes]
        # key_variable = :ModuleBytes
        expect(payment).to have_key(:ModuleBytes)
      end
    
      it "passes, session is not nil" do 
        expect(session).to be_truthy
        expect(session).to be_an_instance_of(Hash)
      end
    
      it "passes, session includes StoredContractByHash key" do 
        expect(session).to have_key(:StoredContractByHash)
      end
    
      it "passes, approvals is not nil" do 
        expect(approvals).to be_truthy
        expect(approvals).to be_an_instance_of(Array)
      end
      
      it "passes, approvals includes signer" do 
        expect(approvals[0]).to have_key(:signer)
      end

      it "passes, approvals includes signature" do 
        expect(approvals[0]).to have_key(:signature)
      end
    end   

    context "When info_get_deploy is called with an empty deploy hash parameter" do  
      deploy = client.info_get_deploy("")
      it "passes,  ServerError: Invalid params " do
        err = "Server error -32602: Invalid params (Jimson::Client::Error::ServerError)"
        expect {raise StandardError, err}.
        to raise_error(err)
      end
    end
  end
  # **********************************************************************************************
  # Test info_get_status()
  describe "#info_get_status" do
    node_status = client.info_get_status
    node_status.deep_symbolize_keys!
    context "Returns the current status of the node" do 
      it "passes, node includes api_version, chainspec_name, starting_state_root_hash, peers, last_added_block_info, our_public_signing_key, round_length, next_upgrade, build_version, uptime keys" do
        expect(node_status).to have_key(:api_version)
        expect(node_status).to have_key(:chainspec_name)
        expect(node_status).to have_key(:starting_state_root_hash)
        expect(node_status).to have_key(:peers)
        expect(node_status).to have_key(:last_added_block_info)
        expect(node_status).to have_key(:our_public_signing_key)
        expect(node_status).to have_key(:round_length)
        expect(node_status).to have_key(:next_upgrade)
        expect(node_status).to have_key(:build_version)
        expect(node_status).to have_key(:uptime)
      end

      it "passes, network is casper" do 
        chainspec_name = node_status[:chainspec_name]
        expect(chainspec_name).to eql("casper")
      end

      it "passes, last added block includes hash, timestamp, era_id, height, state_root_hash, creator keys" do  
        last_block = node_status[:last_added_block_info]
        expect(last_block).to have_key(:hash)
        expect(last_block).to have_key(:timestamp)
        expect(last_block).to have_key(:era_id)
        expect(last_block).to have_key(:state_root_hash)
        expect(last_block).to have_key(:creator)
      end

      it "passes, the number of peers are equal" do
        peers_from_info_get_peers = client.info_get_peers
        peers_from_info_get_status = node_status[:peers]
        expect(peers_from_info_get_status.size).to eql(peers_from_info_get_peers.size)
      end

      it "passes, node public key is : 0145316b84fee8735291f5a29206e5211c74ab828b0382bb475a4a6e799894ea11" do
        our_public_signing_key = "0145316b84fee8735291f5a29206e5211c74ab828b0382bb475a4a6e799894ea11"
        expect(node_status[:our_public_signing_key]).to eql(our_public_signing_key)
      end
    end
  end

  # **********************************************************************************************
  # Test chain_get_block_transfers(block_hash)
  describe "#chain_get_block_transfers" do 
    transfers = client.chain_get_block_transfers(block_hash)
    context "Returns all transfers for a Block from the network" do 
      it "passes, transfers is not empty and the number of transfers is #{transfers.size}" do  
        expect(transfers).not_to be_empty
        expect(transfers.size).to eql(2)
      end

      it "passes, amount of the first transaction is 6000000000000 motes" do 
        first_transaction = transfers[0].deep_symbolize_keys!
        first_transfer_amount = 6000000000000
        expect(first_transaction[:amount].to_i).to eql(first_transfer_amount)
      end
  
      it "passes, amount of the second transaction is 3997300000000 motes" do 
        second_transaction = transfers[1].deep_symbolize_keys!
        second_transfer_amount = 3997300000000
        expect(second_transaction[:amount].to_i).to eql(second_transfer_amount)
      end

      it "passes, all keys in transfers are \'deploy_hash\', \'from\', \'to\', 
      \'source\', \'target\', \'amount\', \'gas\', \'id\' respectively" do
        transfers = transfers[0]
        transfers.deep_symbolize_keys!
        expect(transfers).to have_key(:deploy_hash)
        expect(transfers).to have_key(:from)
        expect(transfers).to have_key(:to)
        expect(transfers).to have_key(:source)
        expect(transfers).to have_key(:target)
        expect(transfers).to have_key(:amount)
        expect(transfers).to have_key(:gas)
        expect(transfers).to have_key(:id)
      end
    end
  end

  # **********************************************************************************************
  # Test chain_get_block(block_hash)
  describe "#chain_get_block" do  
    block_hash = "5fdbdf3fa70d37821aa2d1752743e9653befc15e65e40c2655e1ce93a807260f"
    block = client.chain_get_block(block_hash)
    block.deep_symbolize_keys!
    header = block[:header]
    body = block[:body]
    describe "Returns a Block from the network" do 
      context "When chain_get_block method is called with deploy hash parameter" do 
        it "passes, block hash : #{block[:hash]}" do 
          expect(block[:hash]).to be_truthy
          expect(block[:hash]).to be_a(String)
          expect(block[:hash]).not_to be_empty
          expect(block[:hash].length).to eql(64)
        end
        
        it "passes, hash value of block is equal to the block hash given as parameter" do  
          expect(block[:hash]).to eq(block_hash)   
        end

        it "passes, block includes \'hash\', \'header\', \'body\' and \'proofs\' respectively" do  
          expect(block).to have_key(:hash)
          expect(block).to have_key(:header)
          expect(block).to have_key(:body)
          # expect(block).to have_key(:testtest) # Negative test, uncomment and test again to see the result.
        end
        
        it "passes, header includes \'parent_hash\', \'state_root_hash\', \'body_hash\', \'random_bit\', 
        \'accumulated_seed\', \'era_end\', \'timestamp\', \'era_id\', \'height\', \'protocol_version\' keys respectively" do  
          expect(header).to have_key(:parent_hash)
          expect(header[:parent_hash]).not_to be_empty        # parent_hash is not empty
          expect(header).to have_key(:state_root_hash)
          expect(header[:state_root_hash]).not_to be_empty    # state_root_hash is not empty
          expect(header).to have_key(:body_hash)
          expect(header[:body_hash]).not_to be_empty          # body_hash is not empty
          expect(header).to have_key(:random_bit)
          expect(header[:random_bit]).to be_truthy            # random_bit is true
          expect(header).to have_key(:accumulated_seed)
          expect(header[:accumulated_seed]).not_to be_empty   # accumulated_seed is not empty
          expect(header).to have_key(:era_end)
          expect(header[:era_end]).to be_falsey              # era_end is not nil
          expect(header).to have_key(:timestamp)
          expect(header[:timestamp]).not_to be_empty          # timestamp is not nil
          expect(header).to have_key(:height)
          expect(header[:height]).to be_truthy                # height is not nil
          expect(header).to have_key(:protocol_version)
          expect(header[:protocol_version]).to be_truthy      # protocol_version is not nil
          # expect(header).to have_key(:testtest) # Negative test, uncomment and test again to see the result.
        end

        it "passes, body includes \'proposer\', \'deploy_hashes\' and \'transfer_hashes\' keys respectively" do 
          expect(body).to have_key(:proposer)
          expect(body[:proposer]).not_to be_empty
          expect(body).to have_key(:deploy_hashes)
          expect(body[:deploy_hashes]).to be_a_kind_of(Array)
          expect(body).to have_key(:transfer_hashes)
          expect(body[:transfer_hashes]).to be_a_kind_of(Array)
          # expect(body).to have_key(:testtest) # Negative test, uncomment and test again to see the result.
        end

        it "includes public_key and signature keys" do
          proofs = block[:proofs]
          proof_item = proofs[0]
          expect(proof_item).to have_key(:public_key)
          expect(proof_item[:public_key]).not_to be_empty
          expect(proof_item).to have_key(:signature)
          expect(proof_item[:signature]).not_to be_empty
          # expect(proof_item).to have_key(:testtest)  # Negative test, uncomment and test again to see the result.
        end
      end
      context "When chain_get_block method is called without deploy hash parameter" do 
        # Add tests
      end
    end
  end

  # **********************************************************************************************
  # Test chain_get_eraInfo_by_SwitchBlock(block_hash)
  describe "#chain_get_eraInfo_by_SwitchBlock" do 
    context "Returns an EraInfo from the network" do 
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
  end

  # **********************************************************************************************
  # Test state_get_item(state_root_hash, key, path)
  describe "#state_get_item" do 
    context "Returns a stored value from the network" do 
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
  end

  # **********************************************************************************************
  # Test state_get_dictionary_item(state_root_hash, item_key, uref)
  describe "#state_get_dictionary_item" do 
    stored_value = client.state_get_dictionary_item("d5811c438982f231a9152011c0f6ce9ae9c716e8075a6edec8390f10072ecd29","f870e3cadfde21d7d7686fdf3d1a8413838274d363ca7b27ae71fc9125eb6743", "uref-0d689e987db7ee5be246282c3a7badf0411e34baeeab8e9d73c1223ae4ad02e5-007")
    stored_value.deep_symbolize_keys!
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
  describe "#state_get_balance" do 
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