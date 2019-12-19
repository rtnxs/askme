module QuestionsHelper
  HASHTAG_REGEXP = /#[[:word:]]+/i

  def render_with_hashtags(text)
    text.gsub(HASHTAG_REGEXP){|tag| link_to tag, "/hashtags/#{tag.delete('#')}"}.html_safe
  end
end
