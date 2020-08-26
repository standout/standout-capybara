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

module Standout
  module Capybara
    def self.setup_driver
      driver_name = ENV['CAPYBARA']
      is_using_nanobox = `whoami`.chomp == 'gonano'
      fallback_driver = is_using_nanobox ? :nanobox_chrome : :headless_chrome
      driver_name ||= fallback_driver
      driver_name = driver_name.to_sym

      case driver_name
      when :chrome
        Standout::Capybara::Drivers::Chrome.register
        Standout::Capybara::Drivers::Chrome.use!
      when :nanobox_chrome
        Standout::Capybara::Drivers::NanoboxChrome.register
        Standout::Capybara::Drivers::NanoboxChrome.use!
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

    class Error < StandardError; end
  end
end
