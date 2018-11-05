class Pub < ApplicationRecord
  belongs_to :user

  validates :name, :country, :state, :city, presence: true
end
