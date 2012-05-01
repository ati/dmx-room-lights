class DistanceMap
    attr_accessor :x, :y, :w

    def initialize(x,y,w)
        self.x = x
        self.y = y
        self.w = w
    end
    
    def value_at(dx)
        return 1 if w == 1
        return 0 if (x - dx).abs > w/2.0
        return 1 - 2.0*(x - dx).abs/w
    end
end
