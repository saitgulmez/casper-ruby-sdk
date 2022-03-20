module Casper
  module Entity
    class Peer

      # @param [Hash] peer
      # @option peer [String] :node_id
      # @option peer [String] :address 
      def initialize(peer = {})
        @node_id = peer[:node_id]
        @address = peer[:address]
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

