class Display < ActiveRecord::Base
  belongs_to :galaxy
  belongs_to :color_group
end
