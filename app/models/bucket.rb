class Bucket < ApplicationRecord
  belongs_to :space
  has_many :links, dependent: :destroy

  validates :space, presence: true
  validates :name, presence: true

  def is_editable_by_space?(user)
    space.user.id == user.id
  end
end
