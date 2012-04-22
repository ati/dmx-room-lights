class Galaxy < ActiveRecord::Base
  has_many :fixtures
  has_many :displays
  has_many :color_groups, :through => :displays

  def get_color_group(group_type)
    self.color_groups.where(:group_type => group_type).first
  end
end
