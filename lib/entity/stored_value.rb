
module Casper
  module Entity

    # A class that represents a value stored in global state.
    class StoredValue

      # @param [Hash] stored_value
      # @option stored_value [CLValue] :CLValue
      # @option stored_value [Account] :Account
      # @option stored_value [String] :ContractWasm
      # @option stored_value [Contract] :Contract
      # @option stored_value [ContractPackage] :ContractPackage
      # @option stored_value [Transfer] :Transfer 
      # @option stored_value [DeployInfo] :DeployInfo 
      # @option stored_value [EraInfo] :EraInfo 
      # @option stored_value [Bid] :Bid
      # @option stored_value [Array] :Withdraw 
      def initialize(stored_value = {})
        @stored_value = stored_value
        @cl_value = nil
        @account = nil
        @contract_wasm = nil
        @contract = nil
        @contract_package = nil
        @transfer = nil
        @deploy_info = nil
        @era_info = nil
        @bid = nil
        @withdraw = nil
        @key = nil
        if stored_value.has_key?(:CLValue)
          @cl_value = stored_value[:CLValue]
          @key = :CLValue
        end
        if stored_value.has_key?(:Account)
          @account = stored_value[:Account]
          @key = :Account
        end
        if stored_value.has_key?(:ContractWasm)
          @contract_wasm = stored_value[:ContractWasm]
          @key = :ContractWasm
        end
        if stored_value.has_key?(:Contract)
          @contract = stored_value[:Contract]
          @key = :Contract
        end
        if stored_value.has_key?(:ContractPackage)
          @contract_package = stored_value[:ContractPackage]
          @key = :ContractPackage
        end
        if stored_value.has_key?(:Transfer)
          @transfer = stored_value[:Transfer]
          @key = :Transfer
        end
        if stored_value.has_key?(:DeployInfo)
          @transfer = stored_value[:DeployInfo]
          @key = :Deploy
        end
        if stored_value.has_key?(:EraInfo)
          @era_info = stored_value[:EraInfo]
          @key = :EraInfo
        end
        if stored_value.has_key?(:Bid)
          @bid = stored_value[:Bid]
          @key = :Bid
        end
        if stored_value.has_key?(:Withdraw)
          @withdraw = stored_value[:Withdraw]
          @key = :Withdraw
        end
      end

      # @return [CLValue] a CasperLabs value.
      def get_cl_value
        @cl_value
      end

      # @return [Account] an account.
      def get_account
        @account
      end

      # @return [String] a contract’s Wasm
      def get_contract
        @contract
      end
      
      # @return [Contract] methods and type signatures supported by a contract.
      def get_contract
        @contract
      end
      #  @return [ContractPackage] contract definition, metadata, and security container.
      def get_contract_package
        @contract_package
      end

      # @return [Transfer] record of a transfer
      def get_transfer
        @transfer
      end

      # @return [DeployInfo] record of a deploy
      def get_deploy_info
        @deploy_info
      end

      # @return [EraInfo] auction metadata
      def get_era_info
        @era_info
      end

      # @return [Bid] a bid
      def get_bid
        @bid
      end

      # @return [Array] a withdraw
      def get_withdraw
        @withdraw
      end

      def get_stored_value
        @stored_value[@key]
      end

      def get_key
        @key
      end
    end
  end
end