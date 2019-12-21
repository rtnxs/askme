class Question < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true

  has_many :hashtags_questions
  has_many :hashtags, :through => :hashtags_questions, dependent: :destroy

  validates :text, presence: true, length: {maximum: 255}

  after_save :create_hashtags

  after_commit :destroy_unused_hashtags, on: [:update, :destroy]

  def create_hashtags
    self.hashtags.destroy_all

    "#{text} #{answer}".downcase.scan(HASHTAG_REGEXP).uniq.each do |hashtag|
      tag = Hashtag.find_or_create_by(name: hashtag.delete('#'))
      self.hashtags << tag
    end
  end

  def destroy_unused_hashtags
    Hashtag.includes(:questions).where(questions: {id: nil}).destroy_all
  end
end
