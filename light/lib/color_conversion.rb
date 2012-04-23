class ColorConversion
  #http://axonflux.com/handy-rgb-to-hsl-and-rgb-to-hsv-color-model-c
  def self.hsv2rgb(h,s,v)
    r = g = b = 0
    h = h/360.0
    s = s/100.0
    v = v/100.0

    i = (h*6).floor
    f = h*6 - i
    p = v(1-s)
    q = v*(1-f*s)
    t = v*(1-(1-f)*s)

    case i%6
    when 0
      [v,t,p]
    when 1
      [q,v,p]
    when 2
      [p,v,t]
    when 3
      [p,q,v]
    when 4
      [t,p,v]
    when 5
      [v,p,q]
    end.map {|x| (x*255).to_i }
  end
end
