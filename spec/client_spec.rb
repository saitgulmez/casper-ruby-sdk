#spec/client_spec.rb
require './lib/casper_sdk.rb'

describe CasperClient do
  client1 = CasperClient.new("185.246.84.43")
  # Test info_get_peers()
  describe "#info_get_peers" do
    it "returns peers array." do
      # Check whether ıt is an array or not
      expect(client1.info_get_peers).to be_an(Array)
      # Check the length of the peers array 
      expect(client1.info_get_peers.length).to be > 0

    end
  end   
   # Test chain_get_StateRootHash() 
  describe "#chain_get_StateRootHash" do
    it "returns current state_root_hash." do
      # Check whether its type is string or not
      expect(client1.chain_get_StateRootHash).to be_an(String)
    end
  end  


end