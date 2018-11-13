class User < ApplicationRecord
  has_many :beers, dependent: :destroy
  has_many :pubs, dependent: :destroy
  has_many :styles, dependent: :destroy

  has_secure_password

  validates :email, presence: true, uniqueness: true

  enum role: %i[guest default admin]
end
