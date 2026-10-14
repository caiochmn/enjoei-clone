require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup { @user = users(:ana) }

  test "new" do
    get new_session_path
    assert_response :success
    assert_equal "/entrar", new_session_path
  end

  test "create with valid credentials" do
    post session_path, params: { email_address: @user.email_address, password: "senha1234" }

    assert_redirected_to root_url
    assert cookies[:session_id]
  end

  test "create with invalid credentials" do
    post session_path, params: { email_address: @user.email_address, password: "errada" }

    assert_redirected_to new_session_path
    assert_nil cookies[:session_id]
  end

  test "destroy" do
    sign_in_as(@user)

    delete sign_out_path

    assert_redirected_to root_path
    assert_empty cookies[:session_id]
  end
end
