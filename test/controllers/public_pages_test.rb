require "test_helper"

class PublicPagesTest < ActionDispatch::IntegrationTest
  test "home lists departments and stores" do
    get root_path

    assert_response :success
    assert_select "nav[aria-label=Departamentos] a", text: "feminino"
    assert_select "a[href=?]", "/brecho-da-ana"
  end

  test "store page is served at /{slug}" do
    get "/brecho-da-ana"

    assert_response :success
    assert_select "h1", "brechó da ana"
  end

  test "unknown store returns 404" do
    get "/lojinha-que-nao-existe"
    assert_response :not_found
  end

  test "department page is served at /{department}/s" do
    get "/feminino/s"

    assert_response :success
    assert_select "h1", "feminino"
    assert_select "section#roupas li", "vestidos"
  end

  test "unknown department returns 404" do
    get "/nao-existe/s"
    assert_response :not_found
  end

  test "brands page" do
    get brands_path

    assert_response :success
    assert_select "li#nike", "Nike"
  end

  test "search placeholder echoes the query" do
    get search_path, params: { q: "vestido" }

    assert_response :success
    assert_select "h1", /vestido/
  end
end
