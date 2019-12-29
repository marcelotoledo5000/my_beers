# frozen_string_literal: true

class User < ApplicationRecord
  has_many :beers, dependent: :destroy
  has_many :pubs, dependent: :destroy
  has_many :styles, dependent: :destroy

  has_secure_password

  validates :email, presence: true, uniqueness: true

  enum role: { guest: 0, default: 1, admin: 2 }
end
