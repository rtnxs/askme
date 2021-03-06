module QuestionsHelper
  def render_with_hashtags(text)
    text.gsub(HASHTAG_REGEXP) { |tag| link_to tag, hashtag_path(tag.downcase.delete('#')) }.html_safe
  end
end
