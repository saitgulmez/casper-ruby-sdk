module Casper
  module Entity
    # Header information of a Deploy.
    class DeployHeader 
     
      # @param [Hash] header
      # @option header [String] :account
      # @option header [Integer] :timestamp
      # @option header [Integer] :ttl
      # @option header [Integer] :gas_price
      # @option header [String] :body_hash
      # @option header [Array] :dependencies
      # @option header [String] :chain_name
      def initialize(header = {})
        @account = header[:account]
        @timestamp = header[:timestamp]
        @ttl = header[:ttl]
        @gas_price = header[:gas_price]
        @body_hash = header[:body_hash]
        @dependencies = header[:dependencies]
        @chain_name = header[:chain_name]
      end


      # @return [String] account
      def get_account
        @account
      end

      # @return [Integer] timestamp
      def get_timestamp
        @timestamp
      end

      # @return [Integer] ttl
      def get_ttl
        @ttl
      end

      # @return [Integer] gas_price
      def get_gas_price
        @gas_price
      end

      # @return [String] body_hash
      def get_body_hash
        @body_hash
      end

      def set_body_hash(body_hash)
        @body_hash = body_hash
      end

      # @return [Array] dependencies
      def get_dependencies
        @dependencies
      end

      # @return [String] chain_name
      def get_chain_name
        @chain_name
      end

      # @return [Hash] Deploy header
      def to_hash
        header = {}
        header[:ttl] = @ttl
        header[:account] = @account
        header[:body_hash] = @body_hash
        header[:gas_price] = @gas_price
        header[:timestamp] = @timestamp
        header[:chain_name] = @chain_name
        header[:dependencies] = @dependencies
        return header
      end
    end
  end
end