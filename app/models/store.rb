class Store < ApplicationRecord
  include Sluggable

  # Caminhos que já são rotas do app e não podem virar endereço de lojinha.
  RESERVED_SLUGS = %w[
    s p m c l ajuda entrar sair cadastro senha perfil anunciar sacola checkout
    up rails assets admin api session sessions passwords
  ].freeze

  belongs_to :user

  slug_from :name

  normalizes :slug, with: ->(s) { s.to_s.strip.downcase }

  validates :name, presence: true, length: { maximum: 60 }
  validates :slug, presence: true, uniqueness: true, length: { maximum: 40 },
    format: { with: /\A[a-z0-9]+(?:-[a-z0-9]+)*\z/, message: :invalid_slug },
    exclusion: { in: ->(_) { RESERVED_SLUGS + Category.departments.pluck(:slug) }, message: :reserved }
  validates :bio, length: { maximum: 500 }
  validates :rating_average, numericality: { in: 0..5 }, allow_nil: true

  def to_param
    slug
  end
end
