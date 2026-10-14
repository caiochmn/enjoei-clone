require "test_helper"

class MyStoresControllerTest < ActionDispatch::IntegrationTest
  test "requires sign in" do
    get my_store_path
    assert_redirected_to new_session_path
  end

  test "shows the signed in user's store" do
    sign_in_as(users(:ana))

    get my_store_path
    assert_response :success
    assert_equal "/perfil/minha-lojinha", my_store_path
    assert_select "h1", "brechó da ana"
  end

  test "updates name, slug and bio" do
    sign_in_as(users(:ana))

    patch my_store_path, params: { store: { name: "Achados da Ana", slug: "achados-da-ana", bio: "Novidades toda semana." } }

    assert_redirected_to my_store_path
    store = stores(:ana).reload
    assert_equal "achados-da-ana", store.slug
    assert_equal "Novidades toda semana.", store.bio
  end

  test "does not accept a slug taken by another store" do
    sign_in_as(users(:ana))

    patch my_store_path, params: { store: { slug: "garagem-do-bruno" } }

    assert_response :unprocessable_entity
    assert_equal "brecho-da-ana", stores(:ana).reload.slug
  end
end
