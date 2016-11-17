class Course < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :description, presence: true
  validates :cost, presence: true, numericality: { greater_than: 0 }
end
