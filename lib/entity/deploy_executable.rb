require_relative './deploy_named_argument.rb'
require_relative './module_bytes.rb'
require_relative './deploy_executable_transfer.rb'
require_relative '../utils/helpers.rb'
require_relative '../serialization/deploy_serializer.rb'
module Casper
  module Entity
    # DeployExecutable
    class DeployExecutable 
      include Utils::Helpers
      attr_accessor :module_bytes, :transfer, :stored_contract_by_hash, :stored_contract_by_name,
      :stored_versioned_contract_by_hash, :stored_versioned_contract_by_name
      
      def initialize(h = {})
        deploy_serializer = DeploySerializer.new()
        temp_args = []
        deploy_serializer = DeploySerializer.new
        if h.keys[0] == :ModuleBytes
          args = h[:ModuleBytes][:args]
          args.each do |arg|
            name1 = arg[0]
            clvalue_hash = arg[1]
            clvalue = deploy_serializer.build_cl_value(arg[1])
        
            temp_args << [Casper::Entity::DeployNamedArgument.new(name1, clvalue)]
          end
          @module_bytes = Casper::Entity::ModuleBytes.new(h[:ModuleBytes][:module_bytes], temp_args)
        elsif h.keys[0] == :Transfer
          temp_args = []
          args = h[:Transfer][:args]

          transfer = Casper::Entity::DeployExecutableTransfer.new(args)

          args.each do |arg|
            name1 = arg[0]
            if name1 == "amount" || name1 == "target"
              clvalue_hash = arg[1]
              clvalue = deploy_serializer.build_cl_value(arg[1])
              temp_args << [Casper::Entity::DeployNamedArgument.new(name1, clvalue)]
            elsif name1 == "id"
              bytes = arg[1][:bytes]
              parsed = arg[1][:parsed]
              h = arg[1][:cl_type]
              key, value = h.first
              cl_type = h.keys[0]
              inner_type = value

              inner_clvalue = Utils::Helpers.construct_inner_clvalue(inner_type, parsed)
              clvalue = CLOption.new(inner_clvalue, inner_type)

              temp_args << [Casper::Entity::DeployNamedArgument.new(name1, clvalue)]
            end
          end
          @transfer = Casper::Entity::DeployExecutableTransfer.new(temp_args)
        end
        @stored_contract_by_hash = nil
        @stored_contract_by_name = nil
        @stored_versioned_contract_by_hash = nil
        @stored_versioned_contract_by_name = nil
         # @transfer = nil
      end

      def standard_payment(payment_amount)
        @module_bytes = ModuleBytes.new("", [])
        arg = DeployNamedArgument.new("amount", CLu512.new(payment_amount))
        @module_bytes.set_arg(arg)
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
        else
          raise "failed to serialize ExecutableDeployItemJsonWrapper"
        end
      end
    end
  end
end