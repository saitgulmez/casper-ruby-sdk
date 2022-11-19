require 'jimson'
require 'json'
require 'rdoc/rdoc'
require "ipaddress"
require 'resolv'
require 'rest-client'
require 'active_support/core_ext/hash/keys'
require 'timeout'
require 'net/http'
# require "./rpc/rpc.rb"
require_relative './rpc/rpc_error.rb'
require_relative './rpc/rpc_client.rb'
require_relative './serialization/deploy_serializer.rb'
# Dir["./entity/*.rb"].each {|file|  require  file }
# Dir["./serialization/*.rb"].each {|file|  require file }
# Dir["./types/*.rb"].each {|file|  require file }
require_relative './include.rb'
require_relative './crypto/ed25519_key.rb'
require_relative './crypto/asymmetric_key.rb'
module Casper
   # Interacting with the network
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
     
      @rpc_error = Casper::RpcError::ErrorHandle.new
      @err = @rpc_error.error_handling(@url)

      @pr = []

    end

    def get_error 
      @err
    end

    # @return [Array<Hash>] peers array
    # def info_get_peers
    #     begin
    #       client = Jimson::Client.new(@url)
    #       response = client.info_get_peers
    #       @peer_array = response["peers"]
    #     rescue
    #       @rpc_error = Casper::RpcError::ErrorHandle.new
    #       @error = @rpc_error.error_handling(@url)
    #     end
    # end

    # @return [Array<Hash>] peers array
    def info_get_peers
        begin
          client = Jimson::Client.new(@url)
          response = client.info_get_peers
          @peers = response["peers"]
          # @peers.map! do |peer|
          #   peer.symbolize_keys
          # end
          @peers.map { |item| @pr << Casper::Entity::Peer.new(item.symbolize_keys) }
          @pr
        rescue
          @rpc_error = Casper::RpcError::ErrorHandle.new
          @error = @rpc_error.error_handling(@url)
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
        @rpc_error = Casper::RpcError::ErrorHandle.new
        @error = @rpc_error.error_handling(@url)
      end
    end

    # Get information about a single deploy by hash.
    # @param [String] deploy_hash
    # @return [Hash] Deploy
    # def info_get_deploy(deploy_hash)
    #   begin
    #     status = Timeout::timeout(10) {
    #       client = Jimson::Client.new(@url)
    #       response = client.info_get_deploy({"deploy_hash"=> deploy_hash })
    #       if (deploy_hash == "" || deploy_hash == nil)
    #         Casper::RpcError::InvalidParameter.error
    #       end
    #       @deploy = response["deploy"]
    #       # @deploy.keys.each do |key|  
    #       #     @deploy[(key.to_sym rescue key) || key] = @deploy.delete(key)
    #       # end
    #       @deploy
    #     }
    #   rescue
    #     Casper::RpcError::InvalidParameter.error 
    #   end
    # end
    def info_get_deploy(deploy_hash)
      @dep = nil
      begin
        status = Timeout::timeout(60) {
          client = Jimson::Client.new(@url)
          response = client.info_get_deploy({"deploy_hash"=> deploy_hash })
          if (deploy_hash == "" || deploy_hash == nil)
            Casper::RpcError::InvalidParameter.error
          end
          # @deploy.keys.each do |key|  
          #     @deploy[(key.to_sym rescue key) || key] = @deploy.delete(key)
          # end
          temp = []
          @deploy = response["deploy"]
          @deploy.deep_symbolize_keys!
          Casper::Entity::Deploy.new(@deploy[:hash], @deploy[:header], @deploy[:payment], @deploy[:session], @deploy[:approvals])
        }
      rescue
        Casper::RpcError::InvalidParameter.error 
      end
    end


    # Receive node status information 
    # @return node_status
    def info_get_status
      begin
        status = Timeout::timeout(10) {
          client = Jimson::Client.new(@url)
          @node_status = client.info_get_status
          @node_status.deep_symbolize_keys!
          Casper::Entity::Status.new(@node_status)
        }
      rescue
        @rpc_error = Casper::RpcError::ErrorHandle.new
        @error = @rpc_error.error_handling(@url)
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
          @transfers = response["transfers"]
          @transfers.map { |transfer| Casper::Entity::Transfer.new(transfer.deep_symbolize_keys!)}
        }
      rescue
        Casper::RpcError::InvalidParameter.error
      end
    end

    # @param [String] block_hash
    # @return [Hash] block_info
    def chain_get_block(block_hash)
      begin 
        state = Timeout::timeout(10) {
          client = Jimson::Client.new(@url)
          result = client.chain_get_block({"block_identifier" => {"Hash" => block_hash}})
          @block_info = result["block"]
          if (!@block_info.empty?() && @block_info["hash"] != block_hash)
            raise("Returned block does not have a matching hash.")
          else
            @block_info.deep_symbolize_keys!
            Casper::Entity::Block.new(@block_info[:hash], @block_info[:header], @block_info[:body], @block_info[:proofs])
          end
        }
      rescue
        Casper::RpcError::InvalidParameter.error
      end
    end

    def get_block_by_height(height)
      begin
        state = Timeout::timeout(10){
          client = Jimson::Client.new(@url)
          result = client.chain_get_block({"block_identifier" => {"Height" => height}})
          @block_info = result["block"]
          if (!@block_info.empty?() && @block_info["header"]["height"] != height)
            raise("Returned block does not have a matching height.")
          else
            @block_info.deep_symbolize_keys!
            Casper::Entity::Block.new(@block_info[:hash], @block_info[:header], @block_info[:body], @block_info[:proofs])
          end
        }
      rescue
        Casper::RpcError::InvalidParameter.error
      end
    end

    # @param [String] block_hash
    # @return [Hash] era_summary
    def chain_get_eraInfo_by_SwitchBlock(block_hash)
      begin
        state = Timeout::timeout(10) {
        client = Jimson::Client.new(@url)
        response = client.chain_get_era_info_by_switch_block("block_identifier" => {"Hash" => block_hash})
        @era_summary = response["era_summary"]
        
        if @era_summary == nil
          Casper::RpcError::InvalidParameter.error
        else
          @era_summary.deep_symbolize_keys!
          Casper::Entity::EraSummary.new(@era_summary)
        end
        }
      rescue
        Casper::RpcError::InvalidParameter.error
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
          @stored_value.deep_symbolize_keys!
          Casper::Entity::StoredValue.new(@stored_value)
        }
      rescue
        Casper::RpcError::InvalidParameter.error
      end
    end

    # @param [String] state_root_hash
    # @param [String] item_key
    # @param [String] uref
    def state_get_dictionary_item(state_root_hash, item_key, uref)
      begin
        state = Timeout::timeout(10) {
          client = Jimson::Client.new(@url)
          response = client.state_get_dictionary_item({
            "state_root_hash" => state_root_hash,
            "dictionary_identifier" => {'URef' => 
              {'seed_uref' => uref, 'dictionary_item_key' => item_key} }})
            @stored_value = response["stored_value"]
            @stored_value.deep_symbolize_keys!
            # cl_type = @stored_value[:CLValue][:cl_type]
            # bytes = @stored_value[:CLValue][:bytes]
            DeploySerializer.new().build_cl_value(@stored_value[:CLValue])
        }
      rescue
        Casper::RpcError::InvalidParameter.error
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
        Casper::RpcError::InvalidParameter.error
      end
    end

    # Returns current auction system contract information.
    # @return [Hash] auction_state
    def state_get_AuctionInfo(block_hash = "")
      begin 
        state = Timeout::timeout(50) {
        client = Jimson::Client.new(@url)
        response = client.state_get_auction_info
        @auction_state = response['auction_state']
        @auction_state.deep_symbolize_keys!
        state_root_hash = @auction_state[:state_root_hash]
        block_height = @auction_state[:block_height]
        era_validators = @auction_state[:era_validators]
        
        bids = @auction_state[:bids]
        Casper::Entity::AuctionState.new(state_root_hash, block_height, era_validators, bids)
        }
      rescue
        @rpc_error = Casper::RpcError::ErrorHandle.new
        @error = @rpc_error.error_handling(@url)
      end
    end
    
    # @param [Deploy] deploy
    def put_deploy(deploy)
      client = Jimson::Client.new(@url)
      response = client.account_put_deploy({
        "deploy" => deploy
      })
    end
  
  end

end
