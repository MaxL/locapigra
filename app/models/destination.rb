class Destination < ActiveRecord::Base
  validates :country_code, presence: true, length: { is: 2 }
  #validates :country_name, presence: true
  validates :shipping_price, presence: true, numericality: true

  def country_name
    country = ISO3166::Country[country_code]
    country.translations[I18n.locale.to_s] || country.name
  end

end
