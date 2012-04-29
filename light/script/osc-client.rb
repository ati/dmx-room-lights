# compatible with ruby 1.8
require 'osc-ruby'

@client = OSC::Client.new( 'localhost', 10000 )
m = OSC::Message.new( "/galaxies/1/value" , 0 )
1000.times do |t|
  @client.send(m)
  sleep(0.01)
end

