# casper_client.rb
require 'jimson'
require 'json'

class CasperClient
  attr_accessor :ip_address, :port, :url, :state_root_hash
  @@test_url = "http://185.246.84.43:7777/rpc" 

  def initialize(ip_address = "", port = 7777)
    @ip_address = ip_address
    @port = port

    if @ip_address == ""
      puts "Enter IP Address:"
      @ip_address = gets.chomp
    end

    @url = "http://" + self.ip_address + ":" + self.port.to_s + "/rpc"

    @state_root_hash = ""
  end

  # Set ip_address and port number by user defined inputs
  def set_ipaddress_and_port_number
    puts "Enter IP Address:"
    @ip_address = gets.chomp    
    puts "Enter Port Number:"   
    @port = gets.chomp.to_i
    self.url = "http://" + self.ip_address + ":" + self.port.to_s + "/rpc"
    self.url = "http://" + self.ip_address + ":" + "7777/rpc"
  end


  def set_ip_and_port(ip, port)
    @ip = ip
    @port = port
  end

  # Return peers.
  def info_get_peers
    # set_ipaddress_and_port_number
    client = Jimson::Client.new(self.url)
    result = client.info_get_peers
  end

  # Return state_root_hash value
  def chain_get_StateRootHash
    client = Jimson::Client.new(self.url)
    result = client.chain_get_state_root_hash
    @state_root_hash = result["state_root_hash"]
  end

  def info_get_deploy
    client = Jimson::Client.new(@@test_url)
    result = client.info_get_deploy
  end


  def state_get_AuctionInfo
    client = Jimson::Client.new(@@test_url)
    result = client.state_get_auction_info
    result
  end
 

end

# Create an instance
client1 = CasperClient.new
client2 = CasperClient.new("164.68.97.38")
# client3 = CasperClient.new("78.31.71.19")

# Test info_get_peers
puts client1.info_get_peers
# puts client2.info_get_peers
# puts client3.info_get_peers

# Test chain_get_StateRootHash
# puts client1.chain_get_StateRootHash
# puts client2.chain_get_StateRootHash
# puts client3.chain_get_StateRootHash

# Test info_get_deploy
# puts client1.info_get_deploy
# puts client2.info_get_deploy
# puts client3.info_get_deploy

# Test state_get_AuctionInfo
# puts client1.state_get_AuctionInfo
# puts client2.state_get_AuctionInfo
# puts client3.state_get_AuctionInfo