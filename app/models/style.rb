class Style < ApplicationRecord
  has_many :beers, dependent: :destroy

  validates :name, :school_brewery, presence: true
end
