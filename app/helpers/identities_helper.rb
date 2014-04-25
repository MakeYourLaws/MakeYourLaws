module IdentitiesHelper
  def unavailable_providers
    [:coinbase]
  end

  def provider_image provider, size = 32
    if [:aol, :basecamp, :campfire, :facebook, :github, :google, :linkedin, :myspace, :open_id, :presently, :twitter, :yahoo].include? provider.to_sym
      image_tag("authbuttons/#{provider.to_s.downcase.gsub(/[^a-z]/,'')}_#{size}.png",
        :alt => "#{OmniAuth::Utils.camelize provider}", :size => "#{size}x#{size}")
    else
      image_tag("#{provider.to_s.downcase.gsub(/[^a-z]/,'')}_#{size}.png",
          :alt => "#{OmniAuth::Utils.camelize provider}", :size => "#{size}x#{size}")
    end
  end

  def identity_card identity, size = :slim
    div_for identity, :class => size do
      content = provider_image identity.provider #, ((size == :slim) ? 16 : 32)
      content += content_tag :div, OmniAuth::Utils.camelize(identity.provider), :class => "provider_name" if size != :slim
      if identity.url
        content += content_tag :div, link_to(identity.display_name, identity.url), :class => "uid"
      else
        content += content_tag :div, identity.display_name, :class => "uid"
      end
      content += link_to "X", identity, :method => :delete, :class => "remove",
        :data => {:confirm => 'Are you sure you want to remove this authentication option?' } if size != :slim
        # TODO: authorization
      content
    end
  end
end
