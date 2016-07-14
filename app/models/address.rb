class Address < ActiveRecord::Base
  belongs_to :order

  AVAILABLE_COUNTRIES = [
    "DE", "AT", "CH", "DK", "NL", "FR", "GB", "US"
  ]

  validates :recipient, presence: true
  validates :street, presence: true
  validates :city, presence: true
  validates :zip, presence: true
  validates :state, presence: true
  validates :country, presence: true
  validates_inclusion_of :country, in: AVAILABLE_COUNTRIES



end
