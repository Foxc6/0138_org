RailsAdmin::Config::Fields::Types::FileUpload.class_eval do

  register_instance_option :pretty_value do
    if value.presence
      v = bindings[:view]
      url = resource_url
      if image
        if svg
          v.link_to(v.image_tag(url, class: 'img-polaroid'), url, target: '_blank')
        else
          thumb_url = resource_url(thumb_method)
          url != thumb_url ? v.link_to(v.image_tag(thumb_url, class: 'img-polaroid'), url, target: '_blank') : v.image_tag(thumb_url)
        end
      else
        v.link_to(nil, url, target: '_blank')
      end
    end
  end

  register_instance_option :image? do
    (url = resource_url.to_s) && url.split('.').last =~ /jpg|jpeg|png|gif|svg/i
  end

  register_instance_option :svg? do
    (url = resource_url.to_s) && url.split('.').last =~ /svg/i
  end
end