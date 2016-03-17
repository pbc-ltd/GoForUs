# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path
Rails.application.config.assets.paths << Rails.root + 'app/assets/fonts/'
Rails.application.config.assets.paths << Rails.root + 'app/assets/logos/'
Rails.application.config.assets.paths << Rails.root + 'app/assets/slider/'
Rails.application.config.assets.paths << Rails.root + 'app/assets/parallax-slider/'
Rails.application.config.assets.paths << Rails.root + 'app/assets/icons/'

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.

## CSS
Rails.application.config.assets.precompile += %w( social-icons.css hover.css fancybox.css font-awesome.css font-awesome-ie7.css )
Rails.application.config.assets.precompile += %w( glyphicons.css halfings.css )
Rails.application.config.assets.precompile += %w( style.css parallax-slider.css bootstrap1.css )

# JS
Rails.application.config.assets.precompile += %w( jquery-1.9.1.min.js bootstrap.js jquery.isotope.min.js jquery.imagesloaded.js  )
Rails.application.config.assets.precompile += %w( flexslider.js carousel.js jquery.cslider.js slider.js jquery.fancybox.js )
Rails.application.config.assets.precompile += %w( excanvas.js jquery.flot.js jquery.flot.pie.min.js jquery.flot.stack.js jquery.flot.resize.min.js )
Rails.application.config.assets.precompile += %w( custom.js jquery.gmap.min.js )
