# frozen_string_literal: true

class Style < ApplicationRecord
  belongs_to :user
  has_many :beers, dependent: :destroy

  validates :name, :school_brewery, presence: true
end
