class Job < ApplicationRecord
  validates_presence_of :wage_upper_bound
  validates_presence_of :wage_lower_bound
  validates :wage_lower_bound, numericality: { greater_than: 0 }
end
