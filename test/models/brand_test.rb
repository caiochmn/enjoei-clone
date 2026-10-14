require "test_helper"

class BrandTest < ActiveSupport::TestCase
  test "generates slug from name" do
    assert_equal "levi-s", Brand.create!(name: "Levi's").slug
  end

  test "name is unique regardless of case" do
    assert_not Brand.new(name: "NIKE").valid?
  end
end
