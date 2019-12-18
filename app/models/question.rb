class Question < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true

  has_and_belongs_to_many :hashtags

  validates :text, presence: true, length: {maximum: 255}

  before_save do
    words = self.text.scan(/#[[:word:]]+/)
    words << self.answer.scan(/#[[:word:]]+/) if self.answer
    create_hashtags(words.flatten)
  end

  def create_hashtags(words)
    words.uniq.map do |hastag|
      tag = Hashtag.find_or_create_by(name: hastag.downcase.delete('#'))
      self.hashtags << tag
    end
  end
end
