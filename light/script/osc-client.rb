# compatible with ruby 1.8
require 'osc-ruby'

@client = OSC::Client.new( '192.168.1.106', 10001 )
m = OSC::Message.new( "/connection/label" , "online" )
#1000.times do |t|
  @client.send(m)
  sleep(1)
#end

