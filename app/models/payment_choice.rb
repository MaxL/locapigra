class PaymentChoice < ActiveRecord::Base
  belongs_to :order
end
