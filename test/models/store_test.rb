require "test_helper"

class StoreTest < ActiveSupport::TestCase
  test "generates a unique slug from the name" do
    user = User.create!(name: "Ana Paula", email_address: "anapaula@example.com", password: "senha1234")
    user.store.update!(name: "Brechó da Ana", slug: nil)

    assert_equal "brecho-da-ana-2", user.store.slug
  end

  test "rejects reserved slugs and department slugs" do
    store = stores(:ana)

    store.slug = "entrar"
    assert_not store.valid?
    assert store.errors[:slug].include?("não está disponível")

    store.slug = "feminino"
    assert_not store.valid?
    assert store.errors[:slug].include?("não está disponível")
  end

  test "rejects slugs with invalid characters" do
    store = stores(:ana)
    store.slug = "minha lojinha!"

    assert_not store.valid?
    assert store.errors[:slug].include?("só pode ter letras minúsculas, números e hífens")
  end

  test "uses the slug in URLs" do
    assert_equal "brecho-da-ana", stores(:ana).to_param
  end
end
