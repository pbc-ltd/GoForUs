module MetaTagHelper
  def meta_viewport
    content_for(:meta_viewport) || 'width=device-width, initial-scale=1'
  end

  def meta_googlebot
    content_for(:meta_googlebot) || 'all'
  end

  def meta_author
    content_for(:meta_author) || 'GoForUs Ltd'
  end

  def meta_description
    content_for(:meta_description) || 'Gain delivery from places that just dont deliver! GoForYou tries to bring you closer to what you want by connecting you with our Partners. Our Parters will go and collect any item from whatever the location and bring it to you for a small delivery fee, plus the cost of the items that need purchasing (if that is the case).'
  end

  def meta_title
    content_for(:meta_title) || 'GoForUs'
  end

  def meta_keywords
    content_for(:meta_keywords) || 'App, Delivery, Partner, Durham, Pickup, Dropoff'
  end

  def meta_og_type
    content_for(:meta_og_type) || 'website'
  end

  def meta_og_locale
    content_for(:meta_og_locale) || 'en_GB'
  end

  def meta_og_site_name
    content_for(:meta_og_site_name) || 'GoForUs'
  end

  def meta_og_image
    content_for(:meta_og_image) || asset_url('slider-delivery.jpg')
  end

  def meta_og_image_type
    content_for(:meta_og_image_type) || 'image/jpeg'
  end

  def meta_og_image_width
    content_for(:meta_og_image_width) || '1800'
  end

  def meta_og_image_height
    content_for(:meta_og_image_height) || '450'
  end
end
