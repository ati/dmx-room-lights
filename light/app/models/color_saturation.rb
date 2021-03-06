class ColorSaturation < ActiveRecord::Base
  belongs_to :color_group
  validates :s,  :numericality => { :only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100 }
  alias_attribute :val, :s
end
