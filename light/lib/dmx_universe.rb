class DmxUniverse

  DMX_HOST = 'localhost'
  DMX_PORT = 37211

  def self.display(bytes)
    #s = UDPSocket.new
    #s.send(bytes.pack("C*"), 0, DMX_HOST, DMX_PORT)
    puts bytes.inspect
    return true
  end
end
