ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)
ENV['USE_FREEDESKTOP_PLACEHOLDER'] ||= 'true'
ENV['FREEDESKTOP_MIME_TYPES_PATH'] ||= File.expand_path('../vendor/bundle/ruby/2.6.0/gems/mimemagic-0.3.10/dummy.xml', __dir__)

require 'bundler/setup' # Set up gems listed in the Gemfile.
require 'bootsnap/setup' # Speed up boot time by caching expensive operations.
