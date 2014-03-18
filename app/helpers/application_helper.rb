module ApplicationHelper
  def m string
     Kramdown::Document.new(string).to_html.html_safe unless string.blank?
  end

  def tor_s
    (tor? ? (hidden_service? ? 'tor' : 'hiddenservice') : 'nontor')
  end

  def t string
    @title = string
    content_for :title, string
    content_tag :h1, string
  end
end
