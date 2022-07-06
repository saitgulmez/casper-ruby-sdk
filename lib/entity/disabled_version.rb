module Casper
  module Entity

    # A disabled version of a contract.
    class DisabledVersion

      # @param [Integer] protocol_version_major
      # @param [Integer] contract_version
      def initialize(protocol_version_major, contract_version)
        @protocol_version_major = protocol_version_major
        @contract_version = contract_version
      end

      # @return [Integer] protocol_version_major
      def get_protocol_version_major
        @protocol_version_major
      end

      # @param [Integer] contract_version
      def get_contract_version
        @contract_version
      end

    end
  end
end