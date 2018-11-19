module Standout
  module Capybara
    module Drivers
      class Base
        def self.use!
          ::Capybara.javascript_driver = driver_name
          ::Capybara.default_driver = driver_name
        end

        def self.register
          ::Capybara::Screenshot.register_driver(driver_name) do |driver, path|
            driver.browser.save_screenshot(path)
          end
        end

        def self.driver_name=(value)
          @driver_name = value
        end

        def self.driver_name
          @driver_name
        end
      end
    end
  end
end
