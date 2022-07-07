module Casper
  module Entity

    # The version of the contract.
    class ContractVersion
      
      # @param [Integer] protocol_version_major
      # @param [Integer] contract_version 
      # @param [String] contract_hash
      def initialize(protocol_version_major, contract_version, contract_hash)
        @protocol_version_major = protocol_version_major
        @contract_version = contract_version
        @contract_hash = contract_hash
      end

      # @return [Integer] protocol_version_major
      def get_protocol_version_major
        @protocol_version_major
      end

      # @return [Integer] contract_version 
      def get_contract_version
        @contract_version
      end
      
      # @return [String] contract_hash
      def get_contract_hash
        @contract_hash
      end

    end    
  end
end