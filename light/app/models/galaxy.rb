class Galaxy < ActiveRecord::Base
  has_many :fixtures
  has_many :displays
  has_many :color_groups, :through => :displays
end
