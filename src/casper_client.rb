# ruby_sdk.rb
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


  def set_ipaddress_and_port_number
    puts "Enter IP Address:"
    @ip_address = gets.chomp    # Input example: 185.246.84.43
    
    puts "Enter Port Number:"   # Input example: 7777
    @port = gets.chomp.to_i
    
    self.url = "http://" + self.ip_address + ":" + self.port.to_s + "/rpc"
  end

  # Return a hash that include peers.
  # Peer {node_id: string; address: string; }
  def info_get_peers
    set_ipaddress_and_port_number

    client = Jimson::Client.new(self.url)
    result = client.info_get_peers
    # puts result
  end

end

obj = CasperClient.new

# Test chain_get_state_root_hash
puts obj.info_get_peers



