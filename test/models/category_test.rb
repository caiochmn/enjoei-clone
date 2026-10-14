require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  test "departments are the root categories in order" do
    assert_equal [ categories(:feminino), categories(:masculino) ], Category.departments.to_a
  end

  test "finds the department of a nested category" do
    assert_equal categories(:feminino), categories(:feminino_vestidos).department
    assert categories(:feminino).department?
  end

  test "slug is unique only among siblings" do
    category = Category.create!(name: "Calçados", parent: categories(:masculino))
    assert_equal "calcados", category.slug

    duplicate = Category.new(name: "Roupas", slug: "roupas", parent: categories(:feminino))
    assert_not duplicate.valid?
  end
end
