class Address < ActiveRecord::Base
  belongs_to :order, inverse_of: :addresses
end
