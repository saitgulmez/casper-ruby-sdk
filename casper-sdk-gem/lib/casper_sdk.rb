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

  # Set new ip address and port
  def set_ip_and_port(ip, port)
    @ip = ip
    @port = port
  end

  # Return peers.
  def info_get_peers
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
