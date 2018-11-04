class Beer < ApplicationRecord
  belongs_to :style

  validates :name, :abv, :ibu, :nationality, :brewery, :description,
            presence: true
end
