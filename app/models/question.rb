class Question < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true

  has_and_belongs_to_many :hashtags

  validates :text, presence: true, length: {maximum: 255}

  before_save do
    tags = self.text.scan(/#[[:word:]]+/i)
    tags << self.answer.scan(/#[[:word:]]+/i) if self.answer
    create_hashtags(tags.flatten.uniq)
  end

  def create_hashtags(tags)
    self.hashtags.all.destroy_all

    tags.map do |hastag|
      tag = Hashtag.find_or_create_by(name: hastag.downcase.delete('#'))
      self.hashtags << tag
    end
  end
end
