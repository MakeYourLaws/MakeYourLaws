module IdentitiesHelper
  def provider_image provider, size = 32
    image_tag("authbuttons/#{provider.to_s.downcase.gsub(/[^a-z]/,'')}_#{size}.png", 
        :alt => "#{provider.to_s.camelcase}", :size => "#{size}x#{size}")
  end
  
  def identity_card identity, size = :slim
    div_for identity, :class => size do
      content = provider_image identity.provider #, ((size == :slim) ? 16 : 32)
      content += content_tag :div, identity.provider.to_s.camelcase, :class => "provider_name" if size != :slim
      if identity.url
        content += content_tag :div, link_to(identity.display_name, identity.url), :class => "uid"
      else
        content += content_tag :div, identity.display_name, :class => "uid"
      end
      content += link_to "X", identity, :method => :delete, :class => "remove", 
        :confirm => 'Are you sure you want to remove this authentication option?' if size != :slim 
        # TODO: authorization
      content
    end
  end
end
