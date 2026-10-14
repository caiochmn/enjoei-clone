require "test_helper"

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test "new" do
    get new_registration_path
    assert_response :success
    assert_equal "/cadastro", new_registration_path
  end

  test "create signs the user in and opens their store" do
    assert_difference [ "User.count", "Store.count" ], 1 do
      post registrations_path, params: { user: {
        name: "Carla Mendes", email_address: "carla@example.com",
        password: "senha1234", password_confirmation: "senha1234"
      } }
    end

    assert_redirected_to my_store_path
    assert cookies[:session_id]
    assert_equal "lojinha-de-carla", User.find_by(email_address: "carla@example.com").store.slug
  end

  test "create with invalid data shows errors" do
    assert_no_difference "User.count" do
      post registrations_path, params: { user: {
        name: "", email_address: "ana@example.com", password: "curta", password_confirmation: "curta"
      } }
    end

    assert_response :unprocessable_entity
    assert_select "#error_explanation li", minimum: 3
  end

  test "signed in users are sent home" do
    sign_in_as(users(:ana))
    get new_registration_path
    assert_redirected_to root_path
  end
end
