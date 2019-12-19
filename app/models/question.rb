class Question < ApplicationRecord
  HASHTAG_REGEXP = /#[[:word:]]+/i

  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true

  has_many :hashtags_questions
  has_many :hashtags, :through => :hashtags_questions, dependent: :destroy

  validates :text, presence: true, length: {maximum: 255}

  after_save do
    tags = text.scan(HASHTAG_REGEXP)
    tags << answer&.scan(HASHTAG_REGEXP)
    create_hashtags(tags.flatten.compact.uniq)
  end

  def create_hashtags(tags)
    self.hashtags.destroy_all

    tags.map do |hashtag|
      tag = Hashtag.find_or_create_by(name: hashtag.downcase.delete('#'))
      self.hashtags << tag
    end
  end
end
