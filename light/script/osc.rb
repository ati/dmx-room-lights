# compatible with ruby 1.8
require 'rubygems'
require 'osc-ruby'

@server = OSC::Server.new( 10000 )
#@client = OSC::Client.new( 'localhost', 3333 )

@hsv = [20, 30, 40]

@server.add_method '/galaxies/1/hue' do | message |
  #@hsv[0] = message[0]
  puts "hue: #{message.to_a[0].to_i}"
end

@server.add_method '/galaxies/1/saturation' do | message |
  puts "saturation: #{message.to_a[0].to_i}"
end

@server.add_method '/galaxies/1/value' do | message |
  puts "value: #{message.to_a[0].to_i}"
end

Thread.new do
  @server.run
end

sleep(120)
