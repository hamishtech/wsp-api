class Link < ApplicationRecord
  belongs_to :bucket
  validates :url, presence: true

  def is_editable_by_user?(user)
    bucket.space.user.id == user.id
  end
end
