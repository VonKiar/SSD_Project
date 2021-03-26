class Article < ApplicationRecord

  has_many :comments, dependent: :destroy
  has_many :article_categories
  has_many :categories, through: :article_categories

  validates :body, length: { minimum: 4 }
  validate :no_bad_words_in_title

  before_save :clean_data

  def no_bad_words_in_title
    if title.downcase.include?('bad')
      errors.add(:title, 'cannot contain bad words')
    end
  end

  def clean_data
    self.title = title.upcase.squish
    self.body = body.humanize
  end
end