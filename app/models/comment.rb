class Comment < ApplicationRecord
  belongs_to :article

  validates :author_name, presence: true, length: { maximum: 50 }
  validates :body, presence: true, length: { maximum: 1000 }
end
