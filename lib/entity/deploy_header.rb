module Casper
  module Entity
    class DeployHeader 
     
      # @param [String] account
      # @param [Integer] timestamp
      # @param [Integer] ttl
      # @param [Integer] gas_price
      # @param [String] body_hash
      # @param [Array] dependencies
      # @param [String] chain_name
      def initialize(account = "", timestamp = 0, ttl, gas_price = 0, body_hash = "", dependencies = [], chain_name = "")
        @account = account
        @timestamp = timestamp
        @ttl = ttl
        @gas_price = gas_price
        @body_hash = body_hash
        @dependencies = dependencies
        @chain_name = chain_name
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

      # @return [Array] dependencies
      def get_dependencies
        @dependencies
      end

      # @return [String] chain_name
      def get_chain_name
        @chain_name
      end
    end
  end
end