# casper_client.rb
require 'jimson'
require 'json'

class CasperClient
  attr_accessor :ip_address, :port, :url, :state_root_hash
  @@test_url = "http://185.246.84.43:7777/rpc" 

  def initialize(ip_address = "", port = 0)
    @ip_address = ip_address
    @port = port
    @url = ""
    @state_root_hash = ""
  end

  # Set ip_address and port number by user defined inputs
  def set_ipaddress_and_port_number
    puts "Enter IP Address:"
    @ip_address = gets.chomp    
    puts "Enter Port Number:"   
    @port = gets.chomp.to_i
    self.url = "http://" + self.ip_address + ":" + self.port.to_s + "/rpc"
  end

  
  def set_ip_and_port(ip, port)
    @ip = ip
    @port = port
  end

  # Return peers.
  def info_get_peers
    set_ipaddress_and_port_number
    client = Jimson::Client.new(self.url)
    result = client.info_get_peers
  end

  # Return state_root_hash value
  def chain_get_StateRootHash
    # Uncomment below line for any ip address that is available in the network
    # self.info_get_peers
    # client = Jimson::Client.new(self.url)

    client = Jimson::Client.new(@@test_url)
    result = client.chain_get_state_root_hash
    @state_root_hash = result["state_root_hash"]
  end




end

# obj = CasperClient.new

# # Test chain_get_state_root_hash
# puts obj.info_get_peers

# # Test chain_get_StateRootHash
# puts obj.chain_get_StateRootHash


