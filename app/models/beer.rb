class Beer < ApplicationRecord
  belongs_to :style
  belongs_to :user

  validates :name, :abv, :ibu, :nationality, :brewery, :description,
            presence: true
end
