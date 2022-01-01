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
    @auction_state = {}
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

  # Get information about a single deploy by hash.
  # * @param deploy_hash
  # * @return Deploy
  def info_get_deploy(deploy_Hash)
    @h = {'deploy_hash' => deploy_Hash }
    client = Jimson::Client.new(self.url)
    result = client.info_get_deploy(@h)
    hash1 = result["deploy"]
    @deploy_hash = result["deploy"]
  end

  # Returns current auction system contract information.
  # * @return auction_state
  def state_get_AuctionInfo
  end

end

