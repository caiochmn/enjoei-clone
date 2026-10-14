require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :headless_chrome, screen_size: [ 1400, 1400 ] do |options|
    # Permite apontar para um Chrome/Chromium fora do PATH (ex.: CHROME_BIN=/opt/chromium).
    options.binary = ENV["CHROME_BIN"] if ENV["CHROME_BIN"].present?
    # Necessário ao rodar o Chrome como root, por exemplo dentro de containers.
    options.add_argument("--no-sandbox") if ENV["CHROME_NO_SANDBOX"].present?
  end
end
