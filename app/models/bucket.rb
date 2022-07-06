class Bucket < ApplicationRecord
  belongs_to :space
  has_many :links

  validates :space, presence: true
  validates :name, presence: true
end
