require_relative './deploy_named_argument.rb'
require_relative './module_bytes.rb'
require_relative './deploy_executable_transfer.rb'

module Casper
  module Entity
    # DeployExecutable
    class DeployExecutable 
      attr_accessor :module_bytes, :transfer, :stored_contract_by_hash, :stored_contract_by_name,
      :stored_versioned_contract_by_hash, :stored_versioned_contract_by_name
      def initialize
        @module_bytes = nil
        @stored_contract_by_hash = nil
        @stored_contract_by_name = nil
        @stored_versioned_contract_by_hash = nil
        @stored_versioned_contract_by_name = nil
        @transfer = nil
      end

      def standard_payment(payment_amount)
        @module_bytes = ModuleBytes.new("", [])
        arg = DeployNamedArgument.new("amount", CLu512.new(payment_amount))
        @module_bytes.set_arg(arg) # => Add arg and return args
        @module_bytes
      end

      # @param [Integer] id
      # @param [Integer] amount
      # @param [CLURef | CLPublicKey] target
      # @param [CLURef | CLPublicKey] source_purse
      # @return [DeployExecutable] 
      def new_transfer(id, amount, target, source_purse = nil)
        if target.instance_of? CLURef
          @target = target
        elsif target.instance_of? CLPublicKey
          @target = target.to_account_hash_byte_array
        else
          raise ArgumentError.new("Please specify target")
        end
        arg1 = DeployNamedArgument.new("amount", CLu512.new(amount))
        # arg2 = DeployNamedArgument.new("target", @target)
        @transfer = DeployExecutableTransfer.new([])
        # @transfer.set_arg(DeployNamedArgument.new("target", @target))
        # @transfer.set_arg(arg1)
        # @transfer.set_arg(arg2)
        # @transfer

        if source_purse != nil
          @transfer.set_arg(DeployNamedArgument.new("source", source_purse))
          # @transfer
        end
        @transfer.set_arg(DeployNamedArgument.new("target", @target))
        @transfer.set_arg(DeployNamedArgument.new("id", CLu64.new(id)))
        @transfer
      end

      def set_module_bytes(module_bytes)
        @module_bytes = module_bytes
      end

      # @return [ModuleBytes] module_bytes
      def get_module_bytes
        @module_bytes
      end

      # @return [Boolean]
      def module_bytes?
        @module_bytes != nil
      end

      # @param [DeployExecutableTransfer] transfer
      def set_transfer(transfer)
        @transfer = transfer
      end

      def get_transfer
        @transfer
      end

      # @return [Boolean]
      def transfer?
        @transfer != nil
      end

      # @param [StoredContractByHash] stored_contract_by_hash
      def set_stored_contract_by_hash(stored_contract_by_hash)
        @stored_contract_by_hash = stored_contract_by_hash
      end

      def get_stored_contract_by_hash
        @stored_contract_by_hash
      end

      # @return [Boolean]
      def stored_contract_by_hash?
        @stored_contract_by_hash != nil
      end

      # @param [StoredContractByName] stored_contract_by_name
      def set_stored_contract_by_name(stored_contract_by_name)
        @stored_contract_by_name = stored_contract_by_name
      end

      def get_stored_contract_by_name
        @stored_contract_by_name
      end

      # @return [Boolean]
      def stored_contract_by_name?
        @stored_contract_by_name != nil
      end

      # @param [StoredVersionedContractByHash] stored_versioned_contract_by_hash
      def set_stored_versioned_contract_by_hash(stored_versioned_contract_by_hash)
        @stored_versioned_contract_by_hash = stored_versioned_contract_by_hash
      end

      def get_stored_versioned_contract_by_hash
        @stored_versioned_contract_by_hash
      end

      # @return [Boolean]
      def stored_versioned_contract_by_hash?
        @stored_versioned_contract_by_hash != nil
      end

      # @param [StoredVersionedContractByName] stored_versioned_contract_by_name
      def set_stored_versioned_contract_by_name(stored_versioned_contract_by_name)
        @stored_versioned_contract_by_name = stored_versioned_contract_by_name
      end

      def get_stored_versioned_contract_by_name
        @stored_versioned_contract_by_name
      end

      # @return [Boolean]
      def stored_versioned_contract_by_name?
        @stored_versioned_contract_by_name != nil
      end

      def to_bytes
        if module_bytes?
          @module_bytes.to_bytes
        elsif stored_contract_by_name?
          @stored_contract_by_name.to_bytes
        elsif stored_contract_by_hash?
          @stored_contract_by_hash.to_bytes
        elsif stored_contract_by_name?
          @stored_contract_by_name.to_bytes
        elsif stored_versioned_contract_by_hash?
          @stored_versioned_contract_by_hash.to_bytes
        elsif stored_versioned_contract_by_name?
          @stored_versioned_contract_by_name.to_bytes
        elsif stored_versioned_contract_by_hash?
          @stored_versioned_contract_by_hash.to_bytes
        elsif transfer?
          @transfer.to_bytes
        end
        raise "failed to serialize ExecutableDeployItemJsonWrapper"
      end
    end
  end
end