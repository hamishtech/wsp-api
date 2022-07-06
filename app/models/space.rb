class Space < ApplicationRecord
  belongs_to :user
  has_many :buckets

  validates :user, presence: true
  validates :name, presence: true
end
