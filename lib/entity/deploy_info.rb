module Casper
  module Entity
    # Information relating to the given Deploy.
    class DeployInfo
    
      # @param [String] hash
      # @param [Array] transfers
      # @param [String] from
      # @param [String] source
      # @param [String] gas
      def initialize(hash, transfers, from, source, gas)
        @hash = hash
        @transfers = transfers
        @from = from
        @source = source
        @gas = gas
      end

      # @return [String] hash
      def get_hash
        @hash 
      end

      # @return [Array] transfers
      def get_transfers
        @transfers 
      end

      # @return [String] from
      def get_from 
        @from  
      end

      # @return [String] source
      def get_source 
        @source  
      end

      # @return [String] gas
      def get_gas
        @gas  
      end
    end
  end
end