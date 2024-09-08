require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module FinancialEducation
  class Application < Rails::Application
    config.load_defaults 7.1
    config.autoload_lib(ignore: %w(assets tasks))
    config.api_only = true

    # temporary disable minitest until rspec is installed
    config.generators do |g|
      g.test_framework :minitest, spec: false, fixture: false
    end
  end
end
