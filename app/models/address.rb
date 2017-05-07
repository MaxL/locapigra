class Address < ActiveRecord::Base
  belongs_to :order

  validates :recipient, presence: true
  validates :street, presence: true
  validates :city, presence: true
  validates :zip, presence: true
  validates :state, presence: true
  validates :country, presence: true

end
