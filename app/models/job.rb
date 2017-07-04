class Job < ApplicationRecord
  validates :wage_upper_bound, presence: true
  validates :wage_lower_bound, presence: true
  validates :wage_lower_bound, numericality: { greater_than: 0}

  has_many :resumes
  has_many :users, :through => :resumes
end
