# Dir["./types/*.rb"].each {|file|  require  file }
Dir[File.join(
    File.dirname(File.dirname(File.absolute_path(__FILE__))), "/lib/types/*.rb")].each {|file|  require  file }
Dir[File.join(
    File.dirname(File.dirname(File.absolute_path(__FILE__))), "/lib/entity/*.rb")].each {|file|  require  file }
Dir[File.join(
    File.dirname(File.dirname(File.absolute_path(__FILE__))), "/lib/rpc/*.rb")].each {|file|  require  file }
Dir[File.join(
    File.dirname(File.dirname(File.absolute_path(__FILE__))), "/lib/utils/*.rb")].each {|file|  require  file }
# path = File.join(
#     File.dirname(File.dirname(File.absolute_path(__FILE__))),
#     '/lib/types/cl_bool'
# )
# puts path
# require path
# require_relative "./types/cl_bool.rb"
# require_relative "./types/cl_string.rb"

