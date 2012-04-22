class ColorHue < ActiveRecord::Base
  belongs_to :color_group
  validates :h,  :numericality => { :only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 360 }
  alias_attribute :val, :h
end
