# casper_client.rb
require 'jimson'
require 'json'

# Class for interacting with the network via RPC
class CasperClient
  attr_accessor :ip_address, :port, :url, :state_root_hash

  # Constructor 
  # * @param ip_address
  # * @param  port 
  def initialize(ip_address, port = 7777)
    @ip_address = ip_address
    @port = port
    @url = "http://" + self.ip_address + ":" + self.port.to_s + "/rpc"
    @state_root_hash = ""
    @peer_array = []
    @deploy_hash = ""
    @deploy_hashes = []
    @auction_state_array = []
  end

  # * @return peers array
  def info_get_peers
    client = Jimson::Client.new(self.url)
    result = client.info_get_peers
    @peer_array = result["peers"]
  end

  # * @return state_root_hash value
  def chain_get_StateRootHash
    client = Jimson::Client.new(self.url)
    result = client.chain_get_state_root_hash
    @state_root_hash = result["state_root_hash"]
  end

end

