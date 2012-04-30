# compatible with ruby 1.8
require 'osc-ruby'
require 'ruby-prof'

RUNFILE = "./tmp/osc_keep_running"
TIMESTEP = 40.0/1000 # sec
#File.open(RUNFILE, "w") {}

@server = OSC::Server.new( 10000 )
@state = {:hue => 180, :saturation => 50, :value => 50}
@galaxy = Galaxy.find(1)

@server.add_method '/galaxies/1/hue' do | message |
  @state[:hue] = message.to_a[0]
end

@server.add_method '/galaxies/1/saturation' do | message |
  @state[:saturation] = message.to_a[0]
end

@server.add_method '/galaxies/1/value' do | message |
  @state[:value] = message.to_a[0]
end

@server.add_method '/galaxies/1/onoff' do | message |
  @galaxy.onoff(message.to_a[0].to_i)
end

@server.add_method '.*' do |message|
  puts message.inspect
end

puts "Created OSC server, Ctrl-C to quit"

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
    @galaxy.display_hsv(@state[:hue], @state[:saturation], @state[:value])
    prev_state = @state.dup
  end

  prev_t = cur_t
end
