class ColorGroup < ActiveRecord::Base
  has_many :color_hues
  has_many :color_saturations
  has_many :color_values

  has_many :displays
  has_many :galaxies, :through => :displays

  def val_at_distance(distance)
    pts = self.points
    if pts.count == 0
      return 0
    elsif pts.count == 1
      return pts.values.first
    else
      dsts = pts.keys.sort
      if distance <= dsts[0]
        return pts[dsts.first]
      elsif distance >= dsts.last
        return pts[dsts.last]
      else
        # находим две точки в массиве расстояний, между которыми находится distance
        dsts.each_with_index do |cur_d,i|
          if distance <= cur_d
            prev_d = dsts[i-1]
            ratio = 1 - (cur_d - distance) / (cur_d - prev_d)
            return (pts[prev_d] + ( pts[cur_d] - pts[prev_d] )*ratio).round
          end
        end
      end
    end
  end

  def points
    res = []
    case self.group_type
    when 'hue'
      res = self.color_hues
    when 'saturation'
      res = self.color_saturations
    when 'value'
      res = self.color_values
    else
      raise "unknown color group type: #{self.group_type}"
    end
    ret = {}
    res.each do |p|
      ret[p.distance] = p.val
    end
    return ret
  end
end
