class PaymentChoice < ActiveRecord::Base
  belongs_to :order

  default_scope { where(active: true) }
end
