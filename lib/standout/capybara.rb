# frozen_string_literal: true

require 'standout/capybara/version'
require 'capybara'
require 'capybara-screenshot'
require 'selenium-webdriver'
require 'webdrivers'
require 'standout/capybara/drivers/base'
require 'standout/capybara/drivers/chrome'
require 'standout/capybara/drivers/nanobox_chrome'
require 'standout/capybara/drivers/headless_chrome'
require 'standout/capybara/drivers/remote_chrome'

module Standout
  module Capybara
    class Error < StandardError; end

    def self.setup_driver
      case (ENV['CAPYBARA'] || fallback_driver).to_sym
      when :chrome
        Standout::Capybara::Drivers::Chrome.register
        Standout::Capybara::Drivers::Chrome.use!
      when :nanobox_chrome
        Standout::Capybara::Drivers::NanoboxChrome.register
        Standout::Capybara::Drivers::NanoboxChrome.use!
      when :remote_chrome
        Standout::Capybara::Drivers::RemoteChrome.register
        Standout::Capybara::Drivers::RemoteChrome.use!
      else
        Standout::Capybara::Drivers::HeadlessChrome.register
        Standout::Capybara::Drivers::HeadlessChrome.use!
      end

      if ::Capybara.respond_to? :default_max_wait_time
        ::Capybara.default_max_wait_time = ENV.fetch('CAPYBARA_WAIT_TIME') { 30 }.to_i
      else
        ::Capybara.default_wait_time = ENV.fetch('CAPYBARA_WAIT_TIME') { 30 }.to_i
      end
    end

    def self.fallback_driver
      return :nanobox_chrome if nanobox?
      return :remote_chrome if hub_url?

      :headless_chrome
    end

    def self.nanobox?
      `whoami`.chomp == 'gonano'
    end

    def self.hub_url?
      !ENV['HUB_URL'].nil?
    end
  end
end
