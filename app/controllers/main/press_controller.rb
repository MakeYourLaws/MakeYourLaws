class Main::PressController < ApplicationController
  def method_missing page
    if Dir.glob(File.join(Rails.root, 'app', 'views', 'main', 'press', "#{page}.*")).blank?
      head status: 404
    else
      track! 'page load', page: page unless tor?
    end
  end
end
