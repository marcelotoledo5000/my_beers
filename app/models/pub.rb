class Pub < ApplicationRecord
  validates :name, :country, :state, :city, presence: true
end
