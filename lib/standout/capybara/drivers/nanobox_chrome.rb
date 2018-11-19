module Standout
  module Capybara
    module Drivers
      class NanoboxChrome < Standout::Capybara::Drivers::Base
        self.driver_name = :nanobox_chrome

        def self.use!
          ::Capybara.server_host = ENV["HOSTNAME"] if ENV["HOSTNAME"]&.empty?
          super
        end

        def self.register
          ::Capybara.register_driver driver_name do |driver|
            chrome_host = ENV["CHROME_HOST"] || ENV["DATA_CHROME_HOST"]
            ::Capybara::Selenium::Driver.new(driver,
                                           browser: :remote,
                                           desired_capabilities: :chrome,
                                           url: "http://#{chrome_host}:4444/wd/hub")
          end
          super
        end
      end
    end
  end
end
