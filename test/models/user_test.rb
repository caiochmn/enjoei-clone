require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "downcases and strips email_address" do
    user = User.new(email_address: " DOWNCASED@EXAMPLE.COM ")
    assert_equal("downcased@example.com", user.email_address)
  end

  test "creates a store on sign up" do
    user = User.create!(name: "Carla Mendes", email_address: "carla@example.com", password: "senha1234")

    assert_equal "lojinha de carla", user.store.name
    assert_equal "lojinha-de-carla", user.store.slug
  end

  test "requires name and a password with at least 8 characters" do
    user = User.new(email_address: "x@example.com", password: "curta")

    assert_not user.valid?
    assert user.errors.of_kind?(:name, :blank)
    assert user.errors.of_kind?(:password, :too_short)
  end

  test "rejects duplicated email" do
    user = User.new(name: "Outra Ana", email_address: "ANA@example.com", password: "senha1234")

    assert_not user.valid?
    assert user.errors.of_kind?(:email_address, :taken)
  end
end
