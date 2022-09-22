module Casper
  module Entity
    # BlockHeader  
    class BlockHeader

      # @param [Hash] header
      # @option header [String] :parent_hash
      # @option header [String] :state_root_hash
      # @option header [String] :parent_hash
      # @option header [String] :body_hash
      # @option header [Boolean] :random_bit
      # @option header [String] :accumulated_seed
      # @option header [String] :era_end
      # @option header [Integer] :timestamp
      # @option header [Integer] :era_id
      # @option header [Integer] :height
      def initialize(header = {})
        @parent_hash = header[:parent_hash]
        @state_root_hash = header[:state_root_hash]
        @body_hash = header[:body_hash]
        @random_bit = header[:random_bit]
        @accumulated_seed = header[:accumulated_seed]
        @era_end = header[:era_end]
        @timestamp = header[:timestamp]
        @era_id = header[:era_id]
        @height = header[:height]
        @protocol_version = header[:protocol_version]
      end

      # @return [String] parent_hash
      def get_parent_hash
        @parent_hash
      end

      # @return [String] state_root_hash
      def get_state_root_hash
        @state_root_hash
      end

      # @return [String] body_hash
      def get_body_hash
        @body_hash
      end

      # @return [Boolean] random_bit
      def get_random_bit
        @random_bit
      end

      # @return [String] accumulated_seed
      def get_accumulated_seed
        @accumulated_seed
      end

      # @return [String] era_end
      def get_era_end
        @era_end
      end

      # @return [Integer] timestamp
      def get_timestamp
        @timestamp
      end

      # @return [Integer] era_id
      def get_era_id
        @era_id
      end

      # @return [Integer] height
      def get_height
        @height
      end

      # @return [String] protocol_version
      def get_protocol_version
        @protocol_version
      end
    end
  end
end