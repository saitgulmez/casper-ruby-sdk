# casper_network.rb
require 'jimson'
require 'json'
require 'rdoc/rdoc'
require "ipaddress"
require 'resolv'
require 'rest-client'
require 'active_support/core_ext/hash/keys'
require 'timeout'

# Class for interacting with the network via RPC
class CasperClient
  attr_accessor :ip_address, :port, :url, :state_root_hash

  # Constructor 
  # @param [String] ip_address
  def initialize(ip_address)
    @ip_address = ip_address
    @url = "http://" + @ip_address + ":7777/rpc"
    @state_root_hash = ""
    @peer_array = []
    @block_hash = ""
    @deploy = {}
    @node_status = {}
    @block_transfers = []
    @block_info = {}
    @era_summary = {}
    @balance_value = ""
    @auction_state = {}
  end

  # @return [Array<Hash>] peers array
  def info_get_peers
    begin
      status = Timeout::timeout(5) {
        client = Jimson::Client.new(@url)
        result = client.info_get_peers
        @peer_array = result["peers"]
      }
    rescue Timeout::Error 
      'Timeout expired to retrieve peers!'
    end
  end

  # @return [String] state_root_hash value
  def chain_get_StateRootHash(block_hash = "")
    begin 
      status = Timeout::timeout(10) {
        client = Jimson::Client.new(@url)
        result = client.chain_get_state_root_hash
        @state_root_hash = result["state_root_hash"]
      }
    rescue
      'Timeout expired to retrieve state_root_hash value!'
    end
  end

  # Get information about a single deploy by hash.
  # @param [String] block_hash
  # @return [Hash] Deploy
  def info_get_deploy(block_hash)
    begin
      status = Timeout::timeout(5) {
        client = Jimson::Client.new(@url)
        response = client.info_get_deploy({"block_hash"=> block_hash })
        @deploy = response["deploy"]
        @deploy
      }
    rescue
      'Timeout expired to retrieve Deploy!'
    end
  end


  # Receive node status information 
  # @return node_status
  def info_get_status
    begin
      status = Timeout::timeout(5) {
        client = Jimson::Client.new(@url)
        @node_status = client.info_get_status
      }
    rescue
      'Timeout expired to retrieve node status information'
    end
  end

  # @param [String] block_hash
  # @return [Array<Hash>] block_transfers
  def chain_get_block_transfers(block_hash = "") 
    begin
      status = Timeout::timeout(5) {
        client = Jimson::Client.new(@url)
        response = client.chain_get_block_transfers({
          "block_identifier" => {"Hash" => block_hash}
        })
        @block_transfers = response["transfers"]
        @block_transfers
      }
    rescue
      'Timeout expired to retrieve block_transfers'
    end
  end

  # @param [String] block_hash
  # @return [Hash] block_info
  def chain_get_block(block_hash)
    begin 
      state = Timeout::timeout(5) {
        client = Jimson::Client.new(@url)
        result = client.chain_get_block({"block_identifier" => {"Hash" => block_hash}})
        @block_info = result["block"]
        if (!@block_info.empty?() && @block_info["hash"] != block_hash)
          raise("Returned block does not have a matching hash.")
        else
          @block_info
        end
      }
    rescue
      'Timeout expired to retrieve block_info'
    end
  end

  # @param [String] block_hash
  # @return [Hash] era_summary
  def chain_get_eraInfo_by_SwitchBlock(block_hash)
    begin
      state = Timeout::timeout(30) {
      client = Jimson::Client.new(@url)
      response = client.chain_get_era_info_by_switch_block("block_identifier" => {"Hash" => block_hash})
      @era_summary = response["era_summary"]
      @era_summary
      }
    rescue
      'Timeout expired to retrieve era_summary'
    end
  end  
  
  # @param [String] state_root_hash
  # @param [String] key
  # @param [Array] path
  def state_get_item(state_root_hash, key, path)
    begin
      state = Timeout::timeout(20) {
        client = Jimson::Client.new(@url)
        response = client.state_get_item({ 
          "state_root_hash" => state_root_hash, 
          "key" => key,
          "path" => path
        })
        @stored_value = response["stored_value"]
        @stored_value
      }
    rescue
      'Timeout expired to retrieve stored_value'
    end
  end

  # @param [String] state_root_hash
  # @param [String] item_key
  # @param [String] uref
  def state_get_dictionary_item(state_root_hash, item_key, uref)
    begin
      state = Timeout::timeout(5) {
        client = Jimson::Client.new(@url)
        response = client.state_get_dictionary_item({
          "state_root_hash" => state_root_hash,
          "dictionary_identifier" => {'URef' => 
            {'seed_uref' => uref, 'dictionary_item_key' => item_key} }})
        @stored_value = response["stored_value"]
        @stored_value
      }
    rescue
      'Timeout expired to retrieve stored_value'
    end
  end

  # @param [String] state_root_hash
  # @param [String] balance_uref
  def state_get_balance(state_root_hash, balance_uref)
    begin
      state = Timeout::timeout(5) {
        client = Jimson::Client.new(@url)
        response = client.state_get_balance({
          "state_root_hash" => state_root_hash,
          "purse_uref" => balance_uref
        })
        @balance_value = response["balance_value"]
        @balance_value
      }
    rescue
      'Timeout expired to retrieve balance_value'
    end
  end

  # Returns current auction system contract information.
  # @return [Hash] auction_state
  def state_get_AuctionInfo
    begin 
      state = Timeout::timeout(50) {
      client = Jimson::Client.new(@url)
      response = client.state_get_auction_info
      @auction_state = response['auction_state']
      @auction_state
      }
    rescue
      'Timeout expired to retrieve auction_state information!'
    end
  end
end

