module MainHelper
  def btc_anon_image name, size = 16
    image_tag "btc_anon/#{name}_#{size}.png", height: size, width: size
  end
end
