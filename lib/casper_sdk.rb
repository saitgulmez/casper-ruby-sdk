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
    @node_status = {}
    @block_transfers = []
    @block_info = {}
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
    client = Jimson::Client.new(self.url)
    result = client.state_get_auction_info
    @auction_state = result['auction_state']
  end

  # * Receive node status information 
  # * @return node_status
  def info_get_status
    client = Jimson::Client.new(self.url)
    @node_status = client.info_get_status
  end

  # * @return block_transfers
  def chain_get_block_transfers 
    client = Jimson::Client.new(self.url)
    @block_transfers = client.chain_get_block_transfers["transfers"]
  end

  # * @return block_info
  def chain_get_block(block_hash)
    client = Jimson::Client.new(self.url)
    result = client.chain_get_block({"block_identifier" => {"Hash" => block_hash}})
    @block_info = result["block"]
    if (!@block_info.empty?() && @block_info["hash"] != block_hash)
      raise("Returned block does not have a matching hash.")
    else
      @block_info
    end
  end

  # * @param block_hash
  # * @return era_summary
  def chain_get_eraInfo_by_SwitchBlock
    client = Jimson::Client.new(self.url)
    result = client.chain_get_era_info_by_switch_block("block_identifier" => {"Hash" => block_hash})
    result["era_summary"]  
  end  
  
  # * @param state_root_hash
  # * @param key
  # * @param path
  def state_get_item(stateRootHash, key, path)
    client = Jimson::Client.new(self.url)
    response = client.state_get_item({ "state_root_hash" => stateRootHash, "key" => key, "path" => path})
    response["stored_value"]
  end

end

