require_relative 'boot'

require 'rails/all'

# Fix for LibreSSL incompatibility with Rails 6 AEAD ciphers.
# macOS system Ruby 2.6 ships with LibreSSL 3.3.6, which has a broken
# auth_data= implementation for GCM ciphers. Rails 6.0.0 defaults to
# aes-256-gcm for MessageEncryptor and aes-128-gcm for EncryptedFile,
# both of which break on this platform. This MUST be applied before
# Bundler.require or any middleware/credentials setup.
require "active_support/message_encryptor"
require "active_support/encrypted_file"

# Patch 1: Force MessageEncryptor to use CBC (used for cookies, sessions, CSRF)
ActiveSupport::MessageEncryptor.class_eval do
  def self.default_cipher
    "aes-256-cbc"
  end
end

# Patch 2: Force EncryptedFile to use CBC (used for credentials.yml.enc)
ActiveSupport::EncryptedFile.send(:remove_const, :CIPHER) if ActiveSupport::EncryptedFile.const_defined?(:CIPHER)
ActiveSupport::EncryptedFile.const_set(:CIPHER, "aes-128-cbc")

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Blogger
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Force cookie encryption to use CBC instead of GCM (LibreSSL fix).
    # The cookie middleware hardcodes "aes-256-gcm" and ignores
    # MessageEncryptor.default_cipher, so we must set these explicitly.
    config.action_dispatch.use_authenticated_cookie_encryption = false
    config.action_dispatch.encrypted_cookie_cipher = "aes-256-cbc"

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
