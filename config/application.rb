require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)

module Jeeter
  class Application < Rails::Application
    config.encoding = "utf-8"
    config.active_support.escape_html_entities_in_json = true
    config.assets.enabled = true
    config.generators do |g|
      g.orm :active_record
      g.template_engine :haml
    end
    Paperclip::Attachment.default_options[:path] = "#{Rails.root}/public/uploads/:filename"
  end
end
