# Árvore de categorias: departamento > categoria > subcategoria.
# Os departamentos são as categorias sem pai.
class Category < ApplicationRecord
  include Sluggable

  belongs_to :parent, class_name: "Category", optional: true
  has_many :children, -> { order(:position, :name) },
    class_name: "Category", foreign_key: :parent_id, dependent: :destroy, inverse_of: :parent

  slug_from :name, scope: :parent_id

  scope :departments, -> { where(parent_id: nil).order(:position, :name) }

  validates :name, presence: true
  validates :slug, presence: true, uniqueness: { scope: :parent_id }

  def department?
    parent_id.nil?
  end

  def department
    department? ? self : parent.department
  end

  def to_param
    slug
  end
end
