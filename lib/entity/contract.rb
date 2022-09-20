module Casper
  module Entity

    # Information, entry points and named keys belonging to a Contract
    class Contract 
      
      # @param [String] contract_package_hash
      # @param [String] contract_wasm_hash
      # @param [Array] entry_points
      # @param [Array] named_keys
      # @param [String] protocol_version
      def initialize(contract_package_hash, contract_wasm_hash, named_keys, entry_points, protocol_version)
        @contract_package_hash = contract_package_hash
        @contract_wasm_hash = contract_wasm_hash
        @entry_points = entry_points
        @named_keys = named_keys
        @protocol_version = protocol_version
      end

      # @return [String] contract_package_hash
      def get_contract_package_hash
        @contract_package_hash
      end

      # @return [String] contract_wasm_hash
      def get_contract_wasm_hash
        @contract_wasm_hash
      end

      # @return [Array] entry_points
      def get_entry_points
        @entry_points
      end

      # @return [Array] named_keys
      def get_named_keys
        @named_keys
      end

      # @return [String] protocol_version
      def get_protocol_version
        @protocol_version
      end

    end
  end
end