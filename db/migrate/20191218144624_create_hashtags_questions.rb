class CreateHashtagsQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :hashtags_questions do |t|
      t.references :question, foreign_key: true
      t.references :hashtag, foreign_key: true
    end
  end
end
