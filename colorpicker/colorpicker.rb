require 'sinatra'
require 'socket'

# ruby -rubygems ./colorpicker.rb

DMX_HOST = 'localhost'
DMX_PORT = 37211

get '/' do
    redirect to('/c.html')
end

get '/c/:color' do |c|
    send_color(c.scan(/../).map{|color| color.hex})
end

def send_color(triple)
    s = UDPSocket.new
    values = [];
    
    2.times do
        values << triple[0]
        values << triple[1]
        values << triple[2]
    end

    2.times do
        values << 0
        values << triple[0]
        values << triple[1]
        values << triple[2]
    end

    (512 - values.size).times do
        values << 0
    end

    s.send(values.pack("C*"), 0, DMX_HOST, DMX_PORT)
end
