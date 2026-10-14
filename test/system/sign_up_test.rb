require "application_system_test_case"

class SignUpTest < ApplicationSystemTestCase
  test "signing up opens a store that can be renamed" do
    visit root_path
    click_on "criar minha lojinha"

    fill_in "Nome", with: "Elisa Prado"
    fill_in "Email", with: "elisa@example.com"
    fill_in "Senha", with: "senha1234"
    fill_in "Confirme a senha", with: "senha1234"
    click_on "Criar conta"

    assert_text "Sua lojinha já está no ar"
    assert_selector "h1", text: "lojinha de elisa"

    click_on "editar lojinha"
    fill_in "Nome da lojinha", with: "Achados da Elisa"
    fill_in "Endereço", with: "achados-da-elisa"
    click_on "Salvar"

    assert_text "Lojinha atualizada"
    click_on "/achados-da-elisa"
    assert_selector "h1", text: "Achados da Elisa"
  end
end
