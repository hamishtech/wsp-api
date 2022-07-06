class Space < ApplicationRecord
  belongs_to :user
  has_many :buckets, dependent: :destroy

  validates :user, presence: true
  validates :name, presence: true

  def is_editable_by_user?(user)
    user.id == user.id
  end
end
