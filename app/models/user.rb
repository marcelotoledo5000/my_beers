class User < ApplicationRecord
  has_many :beers, dependent: :destroy
  has_many :pubs, dependent: :destroy
  has_many :styles, dependent: :destroy

  validates :email, :password, presence: true
end
