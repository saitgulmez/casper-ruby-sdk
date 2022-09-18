require_relative './deploy_executable_item_internal.rb'

module Casper
  module Entity
    class ModuleBytes < DeployExecutableItemInternal

      # @param [String] module_bytes
      # @param [Array<Array<DeployNamedArgument>>] args
      def initialize(module_bytes=nil, args = [])
        @tag = 0
        @module_bytes = module_bytes
        @args = args
      end

      def get_tag
        @tag
      end
      
      def get_module_bytes
        @module_bytes
      end

      def get_args
        @args
      end

      def set_arg(deploy_named_arg)
        @args << [deploy_named_arg]
      end

      def to_bytes
        bytes = ""
        serializer = DeployNamedArgSerializer.new
        num_of_args = @args.length
        bytes += Utils::ByteUtils.to_u8(@tag)

        if @module_bytes == ""
          bytes += Utils::ByteUtils.to_u32(0)
        end
        bytes += Utils::ByteUtils.to_u32(num_of_args)
        @args.each do |arg|
          arg.each do |item|
            bytes += serializer.to_bytes(item)
          end
        end
        Utils::ByteUtils.hex_to_byte_array(bytes)
      end
    end
  end
end 