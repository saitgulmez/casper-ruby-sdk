# ruby_sdk.rb
require 'jimson'
require 'json'

class CasperClient
  attr_accessor :ip_address, :port, :url, :node_id 
  
  def initialize(ip_address = "", port = 0)
    @ip_address = ip_address
    @port = port
    @url = ""
  end

  def info_get_peers

  end

end

obj = CasperClient.new
obj.info_get_peers
