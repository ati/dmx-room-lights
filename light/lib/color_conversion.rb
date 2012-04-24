class ColorConversion
  # http://www.easyrgb.com/index.php?X=MATH&H=21#text21
  GAMMA = 2.2

  def self.hsv2rgb(h,s,v)
    h = h/360.0
    s = s/100.0
    v = (v/100.0)**GAMMA

    if ( s == 0)
      return [v,v,v].map {|x| (x*255).to_i}
    end

    if ( s == 0)
      return [v,v,v].map {|x| (x*255).to_i}
    end

    vh = (h*6 == 6)? 0 : h*6
    vi = vh.floor
    v1 = v*(1.0 - s)
    v2 = v*(1.0 - s*(vh - vi))
    v3 = v*(1.0 - s*(1.0 - (vh - vi)))

    case vi
    when 0 then [v,v3,v1]
    when 1 then [v2,v,v1]
    when 2 then [v1,v,v3]
    when 3 then [v1,v2,v]
    when 4 then [v3,v1,v]
    else [v,v1,v2]
    end.map {|x| (x*255).to_i }
  end
end
