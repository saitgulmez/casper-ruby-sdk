module Casper
  module Entity
    class Status
      # @param [Hash] status
      # @option status [String] :api_version
      # @option status [String] :chainspec_name
      # @option status [String] :starting_state_root_hash
      # @option status [Array<Hash>] :peers
      # @option status [Hash] :last_added_block_info
      # @option status [String] :our_public_signing_key
      # @option status [Integer] :round_length 
      # @option status [String] :next_upgrade
      # @option status [String] :build_version
      # @option status [String] :uptime
      def initialize(status = {})
        @api_version = status[:api_version] 
        @chainspec_name = status[:chainspec_name] 
        @starting_state_root_hash = status[:starting_state_root_hash] 
        @peers = []
        status[:peers].map { |peer| @peers << Casper::Entity::Peer.new(peer)}
        @last_added_block_info = status[:last_added_block_info]
        @our_public_signing_key = status[:our_public_signing_key]
        @round_length = status[:round_length]
        @next_upgrade = status[:next_upgrade]
        @build_version = status[:build_version]
        @uptime = status[:uptime]
      end

      # @return [String] the RPC API version.
      def get_api_version
        @api_version
      end

      # @return [String] the chainspec name.
      def get_chainspec_name
        @chainspec_name
      end

      # @return [String] the state root hash used at the start of the current sessio
      def get_starting_state_root_hash
        @starting_state_root_hash
      end

      # @return [Array<Peer>] the node ID and network address of each connected peer.
      def get_peers
        @peers
      end

      # @return [Hash] the minimal info of the last block from the linear chain.
      def get_last_added_block_info
        @last_added_block_info
      end

      # @return [String] Our public signing key.
      def get_our_public_signing_key
        @our_public_signing_key
      end

      # @return [Integer] the next round length if this node is a validator.
      def get_round_length
        @round_length
      end

      # @return [String] information about the next scheduled upgrade.
      def get_next_upgrade
        @next_upgrade
      end

      # @return [String] the compiled node version.
      def get_build_version
        @build_version
      end

      # @return [String] the time that passed since the node has started.
      def get_uptime
        @uptime
      end
    end
  end
end