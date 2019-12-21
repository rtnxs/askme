class Question < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true

  has_many :hashtags_questions
  has_many :hashtags, :through => :hashtags_questions, dependent: :destroy

  validates :text, presence: true, length: {maximum: 255}

  after_save do
    tags = ("#{text} #{answer}").downcase.scan(HASHTAG_REGEXP).uniq
    #byebug
    create_hashtags(tags)
  end

  after_commit do
    #byebug
    Hashtag.includes(:questions).where(questions: {id: nil}).destroy_all
  end

  def create_hashtags(tags)
    self.hashtags.destroy_all

    tags.map do |hashtag|
      tag = Hashtag.find_or_create_by(name: hashtag.delete('#'))
      self.hashtags << tag
    end
  end
end
