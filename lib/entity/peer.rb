
module Casper
  class Peer
    # attr_accessor :node_id, :address
    attr_reader :node_id, :address
    
    def initialize(node_id, address)
      @node_id = node_id
      @address = address
    end

    def get_node_id
      @node_id
    end

    def get_address
      @address
    end
  end
end

