#spec/casper_client_spec.rb
require './src/casper_client.rb'

describe CasperClient do
  describe "#set_ipaddress_and_port_number" do
    it "returns true" do
      client = CasperClient.new
      expect(client.set_ipaddress_and_port_number)
    end
  end    
  describe "#info_get_peers" do
    it "returns true" do
      client = CasperClient.new
      # expect(client.info_get_peers)
    end
  end  
  describe "#set_ip_and_port" do
    it "returns true" do
      client = CasperClient.new("185.246.84.43", 7777)
      expect(client.set_ip_and_port("185.246.84.43", 7777))
    end
  end
end