class Galaxy < ActiveRecord::Base
  has_many :fixtures
  has_many :displays
  has_many :color_groups, :through => :displays

  def get_color_group(group_type)
    self.color_groups.each do |c_g|
      return c_g if c_g.group_type == group_type
    end
    return nil
  end
end
