module Standout
  module Capybara
    module Drivers
      class Chrome < Standout::Capybara::Drivers::Base
        self.driver_name = :chrome

        def self.register
          ::Capybara.register_driver driver_name do |driver|
            options = Selenium::WebDriver::Chrome::Options.new
            options.args << "window-size=1920,1024"

            ::Capybara::Selenium::Driver.new(driver,
                                             browser: :chrome,
                                             options: options)
          end
          super
        end
      end
    end
  end
end
