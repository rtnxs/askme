module QuestionsHelper
  def render_with_hashtags(body)
    body.gsub(/#\w+/){|word| link_to word, "/hashtags/#{word.delete('#')}"}.html_safe
  end
end
