# compatible with ruby 1.8
require 'osc-ruby'

@server = OSC::Server.new( 10000 )
#@client = OSC::Client.new( 'localhost', 3333 )

@s = @v = 50
@h = 180
@galaxy = Galaxy.find(1)

@server.add_method '/galaxies/1/hue' do | message |
  @h = message.to_a[0].to_i
  @galaxy.display_hsv(@h, @s, @v)
end

@server.add_method '/galaxies/1/saturation' do | message |
  @s = message.to_a[0].to_i
  @galaxy.display_hsv(@h, @s, @v)
end

@server.add_method '/galaxies/1/value' do | message |
  @v = message.to_a[0].to_i
  @galaxy.display_hsv(@h, @s, @v)
end

@server.add_method '/galaxies/1/onoff' do | message |
  @galaxy.onoff(message.to_a[0].to_i)
end

puts "Created server, now go for eternal light!"

Thread.new do
  @server.run
end

sleep(1) while (true)
