module ApplicationHelper
  def m string
     RDiscount.new(string).to_html.html_safe unless string.blank?
  end  
end
