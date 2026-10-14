class Brand < ApplicationRecord
  include Sluggable

  slug_from :name

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :slug, presence: true, uniqueness: true

  def to_param
    slug
  end
end
