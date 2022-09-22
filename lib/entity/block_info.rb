module Casper
  module Entity
    # BlockInfo class entity
    class BlockInfo

      # @param [Hash] last_added_block_info
      # @option last_added_block_info [String] :hash
      # @option last_added_block_info [String] :timestamp
      # @option last_added_block_info [Integer] :era_id
      # @option last_added_block_info [Integer] :height
      # @option last_added_block_info [String] :state_root_hash
      # @option last_added_block_info [String] :creator
      def initialize(last_added_block_info = {})
        @hash = last_added_block_info[:hash]
        @timestamp = last_added_block_info[:timestamp]
        @era_id = last_added_block_info[:era_id]
        @height = last_added_block_info[:height]
        @state_root_hash = last_added_block_info[:state_root_hash]
        @creator = last_added_block_info[:creator]
      end

      # @return [String] A cryptographic hash identifying a Block.
      def get_hash
        @hash
      end

      # @return [String] Timestamp formatted as per RFC 3339.
      def get_timestamp
        @timestamp
      end

      # @return [Integer] Era ID in which this block was created.
      def get_era_id 
        @era_id
      end

      # @return [Integer] The height of this block, 
      #   i.e., the number of ancestors.
      def get_height
        @height
      end

      # @return [String] The global state root hash produced by 
      #   executing this block’s body.
      def get_state_root_hash
        @state_root_hash
      end

      # @return [String] Hex-encoded cryptographic public key, 
      #   including the algorithm tag prefix.
      def get_creator
        @creator
      end
    end
  end
end