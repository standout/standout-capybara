# frozen_string_literal: true

module Standout
  module Capybara
    module Drivers
      class RemoteChrome < Standout::Capybara::Drivers::Base
        self.driver_name = :remote_chrome

        def self.register
          ::Capybara.register_driver driver_name do |driver|
            chrome_capabilities = ::Selenium::WebDriver::Remote::Capabilities
              .chrome('goog:chromeOptions' => {
                args: %w[no-sandbox headless disable-gpu window-size=1400,1400] })

            ::Capybara::Selenium::Driver.new(driver,
                                             browser: :remote,
                                             url: ENV['HUB_URL'],
                                             desired_capabilities: chrome_capabilities)
          end
          super
        end
      end
    end
  end
end
