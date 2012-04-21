class ColorGroup < ActiveRecord::Base
  has_many :color_hue
  has_many :color_saturation
  has_many :color_value
end
