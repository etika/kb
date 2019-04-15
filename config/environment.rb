# Load the Rails application.
require_relative 'application'
APP_CONFIG = YAML.load(ERB.new(File.read("#{Rails.root}/config/app_config.yml")).result)[Rails.env]
# Initialize the Rails application.
Rails.application.initialize!
