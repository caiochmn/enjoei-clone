class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_one :store, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }
  normalizes :name, with: ->(n) { n.squish }

  validates :name, presence: true, length: { maximum: 80 }
  validates :email_address, presence: true, uniqueness: true,
    format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 8 }, allow_nil: true

  # Toda pessoa cadastrada ganha uma lojinha, como no marketplace original.
  after_create :create_default_store!

  def first_name
    name.split.first
  end

  private
    def create_default_store!
      create_store!(name: "lojinha de #{first_name.downcase}")
    end
end
