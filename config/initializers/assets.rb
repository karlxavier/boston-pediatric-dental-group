# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')
# Rails.application.config.assets.compile = true
Rails.application.config.assets.precompile += %w( Chart.min.js )
Rails.application.config.assets.precompile += %w( charts-home.js )
Rails.application.config.assets.precompile += %w( order.js )
Rails.application.config.assets.precompile += %w( Timer.js )
Rails.application.config.assets.precompile += %w( custom.scss )
Rails.application.config.assets.precompile += %w( color_admin.scss )
Rails.application.config.assets.precompile += %w( bootstrap.min.css )

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )
