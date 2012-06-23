require 'singleton'

class DmxUniverse
  include Singleton

  DMX_HOST = '192.168.1.2'
  DMX_PORT = 37211

  def initialize
    @raw_data = []
    512.times do
      @raw_data << 0
    end
  end

  def copy(f)
    @raw_data[f.start_address - 1] = f.r
    @raw_data[f.start_address] = f.g
    @raw_data[f.start_address + 1] = f.b
  end

  def dump
    puts @raw_data.join(' ')
  end

  def display
    s = UDPSocket.new
    s.send(@raw_data.pack("C*"), 0, DMX_HOST, DMX_PORT)
    #puts @raw_data.inspect
    return true
  end
end
