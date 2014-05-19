class Main::PressController < ApplicationController
  def method_missing page
    raise "Press processing #{page}"
    if !Dir.glob(File.join(Rails.root, 'app', 'views', 'main', 'press', "#{page}.*")).blank?
      track! 'page load', :page => page unless tor?
    end
  end
end
