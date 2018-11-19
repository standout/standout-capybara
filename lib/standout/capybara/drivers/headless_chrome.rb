module Standout
  module Capybara
    module Drivers
      class HeadlessChrome < Standout::Capybara::Drivers::Base
        self.driver_name = :headless_chrome

        def self.register
          ::Capybara.register_driver driver_name do |driver|
            options = Selenium::WebDriver::Chrome::Options.new
            options.args << "window-size=1920,1024"
            options.args << "disable-gpu"
            options.args << "headless"

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
