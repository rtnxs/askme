module ApplicationHelper
  def fa_icon(icon_class)
    content_tag 'span', '', class: "fa fa-#{icon_class}"
  end

  def author(question)
    if question.author.present?
      link_to question.author.username, user_url(question.author)
    else
      'anon'
    end
  end
end
