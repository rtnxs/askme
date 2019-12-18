class HashtagsController < ApplicationController
  before_action :set_hashtag, only: [:show]

  def show
    @questions = @hashtag.questions
  end

  private

  def set_hashtag
    @hashtag = Hashtag.find_by(name: params[:id])
  end
end
