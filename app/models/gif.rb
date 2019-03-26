class Gif < ApplicationRecord
  has_many :reviews
  has_many :users, through: :reviews
  validates :url, presence: true
  validates :title, presence: true

  def gif_json
    {
      id: self.id,
      url: self.url,
      title: self.title,
      avg_rating: self.avg_rating,
      created_at: self.created_at,
      reviews: self.reviews.collect(&:review_json)
    }
  end

  def avg_rating
    self.reviews.average(:rating)
  end

  def self.gif_json
    Gif.all.collect(&:gif_json)
  end
end
