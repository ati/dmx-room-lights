class Galaxy < ActiveRecord::Base
  has_many :fixtures
  has_many :displays
  has_many :color_groups, :through => :displays
  attr_accessor :distance_map
  after_find :initialize

  @dmx_data = []


  def initialize
    self.distance_map = DistanceMap.new(0.5, 0.5, 1.0)
  end


  def get_color_group(group_type)
    self.color_groups.where(:group_type => group_type).first
  end

  def self.display
    self.fill_dmx_data
    # recompute rbg values for all fixtures
    hueg = get_color_group('hue').presence || ColorGroup.new(:group_type => :hue)
    satg = get_color_group('saturation').presence || ColorGroup.new(:group_type => :saturation)
    valg = get_color_group('value').presence || ColorGroup.new(:group_type => :value)

    fixtures.each do |f|
       f.r, f.g, f.b = ColorConversion.hsv2rgb(
         hueg.val_at_distance(f.distance),
         satg.val_at_distance(f.distance),
         valg.val_at_distance(f.distance)
       )
       f.save
       f.setpixel(@dmx_data)
    end

    DmxUniverse.display(@dmx_data)
  end


  def fill_dmx_data
    @dmx_data = []
    512.times { @dmx_data << 0 }
    Fixture.all.map {|f| f.setpixel(@dmx_data) }
  end


  def onoff(is_on)
    self.fill_dmx_data
    if is_on.to_i < 1
      self.fixtures.each do |f|
        f.save
        f.r = f.g = f.b = 0 # don't save!
        f.setpixel(@dmx_data)
      end
    end
    DmxUniverse.display(@dmx_data)
  end


  def display_hsv(h,s,v)
    self.fill_dmx_data
    self.fixtures.each do |f|
       f.r, f.g, f.b = ColorConversion.hsv2rgb(h,s, 1.0*self.distance_map.value_at(f.distance)*v)
       #f.save
       f.setpixel(@dmx_data)
    end
    DmxUniverse.display(@dmx_data)
  end
end
