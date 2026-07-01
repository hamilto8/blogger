class Tag < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :articles, through: :taggings

  validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 30 }

  before_save :clean_name

  private

  def clean_name
    self.name = name.to_s.strip.downcase
  end
end
