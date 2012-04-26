class Fixture < ActiveRecord::Base
  belongs_to :galaxy
  belongs_to :color_hue
  belongs_to :color_saturation
  belongs_to :color_value

  validates_uniqueness_of :start_address, :numericality => { :only_integer => true, :greater_than_or_equal_to => 0, :less_than => 512 }
  validates :distance, :numericality => { :greater_than_or_equal_to => 0.0, :less_than_or_equal_to => 1.0 }
  validates_presence_of :galaxy_id

  def setpixel(dmx_data)
    dmx_data[start_address] = r
    dmx_data[start_address + 1] = g
    dmx_data[start_address + 2] = b
  end
end
