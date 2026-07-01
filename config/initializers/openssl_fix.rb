# frozen_string_literal: true
#
# Fix for LibreSSL incompatibility with Rails 6 AEAD ciphers.
#
# macOS system Ruby 2.6 ships with LibreSSL 3.3.6, which has a bug where
# `OpenSSL::Cipher#auth_data=` raises "couldn't set additional authenticated
# data" for GCM ciphers. Rails 6.0.0 defaults to aes-256-gcm for
# ActiveSupport::MessageEncryptor, which breaks session cookies, credentials,
# and any encrypted message on this platform.
#
# This patch forces MessageEncryptor to use the CBC cipher instead of GCM,
# which works correctly on LibreSSL and is still secure when combined with
# Rails' HMAC message verification.
#

require "active_support/message_encryptor"

module ActiveSupport
  class MessageEncryptor
    # Override the default cipher from aes-256-gcm to aes-256-cbc
    # to avoid LibreSSL's broken AEAD support on macOS system Ruby.
    def self.default_cipher
      "aes-256-cbc"
    end
  end
end
