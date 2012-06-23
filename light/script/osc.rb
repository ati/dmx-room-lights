# compatible with ruby 1.8
require 'osc-ruby'

#RUNFILE = "./tmp/osc_keep_running"
#File.open(RUNFILE, "w") {}
TIMESTEP = 40.0/1000 # sec
SERVER_PORT = 10000
CLIENT_PORT = 10001
CLIENT_ADDR = '192.168.1.102'
UNIVERSE = DmxUniverse.instance

@server = OSC::Server.new( SERVER_PORT )
@client = OSC::Client.new( CLIENT_ADDR, CLIENT_PORT )
prefix = '/galaxies/1/'

@state = {
  :hue => 180, 
  :saturation => 50, 
  :value => 50,
  :onoff => 1,
  :distance_map => 'x:y:w'
}

@galaxy = Galaxy.find(1)
@minw = 1.0/@galaxy.fixtures.count 


@server.add_method "#{prefix}hue" do | message |
  @state[:hue] += message.to_a[0].to_i
  @state[:hue] = 0 if @state[:hue] > 360
  @state[:hue] = 360 if @state[:hue] < 0 
  @client.send(OSC::Message.new( "#{prefix}labels/hue" , 'color: ' + @state[:hue].to_i.to_s))
end

@server.add_method "#{prefix}saturation" do | message |
  @state[:saturation] = message.to_a[0]
  @client.send(OSC::Message.new( "#{prefix}labels/saturation" , 'saturation: ' + @state[:saturation].to_i.to_s))
end

@server.add_method "#{prefix}value" do | message |
  @state[:value] = message.to_a[0]
  @client.send(OSC::Message.new( "#{prefix}labels/value" , 'value: ' + @state[:value].to_i.to_s))
end

@server.add_method "#{prefix}onoff" do | message |
  @galaxy.onoff(message.to_a[0].to_i)
end

@server.add_method "#{prefix}touch/[12]" do |message|
  # x1 (position of the first finger) = light wave center
  # (y2 - y1)/100 = light wave width, W > 0.8 = 1
  if message.address.match(/1$/)
    @galaxy.distance_map.x = message.to_a[0]/100.0
    @galaxy.distance_map.y = message.to_a[1]/100.0

  elsif message.address.match(/2$/)
    w = (message.to_a[1]/100.0 - @galaxy.distance_map.y).abs
    w = 1.0 if w > 1.0
    #w = @minw if w < @minw
    @galaxy.distance_map.w = w
  end

  @state[:distance_map] = [@galaxy.distance_map.x, @galaxy.distance_map.y, @galaxy.distance_map.w].join(':')
  #puts "x:y:w = #{@state[:distance_map]}"
end


@server.add_method "#{prefix}hsv" do |message|
  [:saturation, :value].each do |p|
    @client.send(OSC::Message.new( "#{prefix}#{p}" , @state[p]))
    @client.send(OSC::Message.new( "#{prefix}labels/#{p}" , p.to_s + ': ' + @state[p].to_i.to_s))
  end
  @client.send(OSC::Message.new( "#{prefix}labels/hue" , 'color: ' + @state[:hue].to_i.to_s))
end
  

  
puts "Created OSC server at port #{SERVER_PORT}, sending info to client #{CLIENT_ADDR}:#{CLIENT_PORT}. Ctrl-C to quit"

Thread.new do
  ActiveRecord::Base.cache do
    @server.run
  end
end

prev_t = Time.now.to_f
prev_state = @state.dup

while (true) do
  cur_t = Time.now.to_f
  sleep([0, TIMESTEP - (cur_t - prev_t)].max)
  
  if !prev_state.eql?(@state)
    puts "new state: #{@state.inspect}"
    @galaxy.display_hsv(@state[:hue], @state[:saturation], @state[:value])
    prev_state = @state.dup
    UNIVERSE.display
  end

  prev_t = cur_t
end
