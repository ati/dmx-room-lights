class ColorValue < ActiveRecord::Base
  belongs_to :color_group
  validates :v,  :numericality => { :only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100 }
  alias_attribute :val, :v
end
