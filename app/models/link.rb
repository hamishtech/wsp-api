class Link < ApplicationRecord
  belongs_to :bucket

  validates :url, presence: true
end
