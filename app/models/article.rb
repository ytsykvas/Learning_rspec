class Article < ApplicationRecord
  validates :title, presence: true, length: {maximum: 15}
  validates :body, presence: true, length: {minimum: 5}

  scope :active, -> () { where(active: true)}
  scope :inactive, -> () { where(active: false)}
end