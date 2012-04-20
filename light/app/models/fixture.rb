class Fixture < ActiveRecord::Base
  belongs_to :galaxy
  belongs_to :color_hue
  belongs_to :color_saturation
  belongs_to :color_value
end
