module Casper
  module Entity
    class Peer

      # @param [String] node_id
      # @param [String] address 
      def initialize(node_id, address)
        @node_id = node_id
        @address = address
      end

      # @return [String] node_id
      def get_node_id
        @node_id
      end

      # @return [String] address
      def get_address
        @address
      end
    end
  end
end

