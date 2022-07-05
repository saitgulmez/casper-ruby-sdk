module Casper
  module Entity

    # A class that represents a value stored in global state.
    class StoredValue

      def initialize(cl_value, account, contract, contract_package, transfer, deploy_info, era_info, bid, withdraw)
        @cl_value = cl_value
        @account = account
        @contract = contract
        @contract_package = contract_package 
        @transfer = transfer
        @deploy_info = deploy_info
        @era_info = era_info
        @bid = bid
        @withdraw = withdraw
      end

      def get_cl_value
        @cl_value
      end

      def get_account
        @account
      end

      def get_contract
        @contract
      end

      def get_contract_package
        @contract_package
      end

      def get_transfer
        @transfer
      end

      def get_deploy_info
        @deploy_info
      end

      def get_era_info
        @era_info
      end

      def get_bid
        @bid
      end

      def get_withdraw
        @withdraw
      end

    end
  end
end