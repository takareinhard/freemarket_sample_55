# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'
Rails.application.config.assets.precompile += %w( product_image.js )
Rails.application.config.assets.precompile += %w( payjp.js )
Rails.application.config.assets.precompile += %w( add_category.js )
Rails.application.config.assets.precompile += %w( delivery.js )
Rails.application.config.assets.precompile += %w( price.js )
Rails.application.config.assets.precompile += %w( toppage_banner.js )
Rails.application.config.assets.precompile += %w( product_images.js )

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
