class Galaxy < ActiveRecord::Base
  has_many :fixtures
  has_many :displays
  has_many :color_groups, :through => :displays

  def get_color_group(group_type)
    self.color_groups.where(:group_type => group_type).first
  end

  def self.display
    dmx_data = []
    512.times { dmx_data << 0 }

    # recompute rbg values for all fixtures
    universe = self.all.includes(:fixtures, :color_groups)
    universe.each do |glx|

      hueg = glx.get_color_group('hue').presence || ColorGroup.new(:group_type => :hue)
      satg = glx.get_color_group('saturation').presence || ColorGroup.new(:group_type => :saturation)
      valg = glx.get_color_group('value').presence || ColorGroup.new(:group_type => :value)

      glx.fixtures.each do |f|
         f.r, f.g, f.b = ColorConversion.hsv2rbg(
           hueg.val_at_distance(f.distance),
           satg.val_at_distance(f.distance),
           valg.val_at_distance(f.distance)
         )
         f.save
         dmx_data[f.start_address] = f.r
         dmx_data[f.start_address+1] = f.g
         dmx_data[f.start_address+2] = f.b
      end
    end

    DmxUniverse.display(dmx_data)
  end
end
