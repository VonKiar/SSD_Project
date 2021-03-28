class Article < ApplicationRecord
  enum status: { draft: 0, published: 1, archived: 2  }

  scope :long_title, -> (length = 15) { where('LENGTH(title) > ?', length) }
  scope :short_body, -> (length = 5) { where('LENGTH(body) < ?', length) }
  scope :search, -> (arg) { where("title LIKE ? or body LIKE ?", "%#{arg}%", "%#{arg}%") }

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

  def test_atomic_function
    Article.transaction do
      update title: "Atomic part A"
      # Complicated code starts
      raise "Something goes wrong"
      # Complicated code ends
      update title: "Atomic part B"
    end
  end
end