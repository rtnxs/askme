module QuestionsHelper
  def render_with_hashtags(text)
    text.gsub(/#[[:word:]]+/i){|tag| link_to tag, "/hashtags/#{tag.delete('#')}"}.html_safe
  end
end
