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
    puts "Enter IP Address:"
    @ip_address = gets.chomp    # Example: 185.246.84.43
    
    puts "Enter Port Number:"   # Example: 7777
    @port = gets.chomp.to_i
    
    self.url = "http://" + self.ip_address + ":" + self.port.to_s + "/rpc"
    
    client = Jimson::Client.new(self.url)
    result = client.info_get_peers
    # puts result
  end

end

obj = CasperClient.new
obj.info_get_peers
