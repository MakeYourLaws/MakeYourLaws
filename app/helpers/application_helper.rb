module ApplicationHelper
  def m string
     RDiscount.new(string).to_html.html_safe unless string.blank?
  end  
  
  def t string
    content_for :title, string
    content_tag :h1, string
  end
end
