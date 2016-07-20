module CartsHelper

  def available_countries
    @destinations = Destination.all
    @available_countries = Array.new
    @destinations.each do |destination|
      @available_countries.push(destination.country_code)
    end
    return @available_countries
  end
end
