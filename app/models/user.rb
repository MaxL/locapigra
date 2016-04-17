class User < ActiveRecord::Base
  authenticates_with_sorcery!

  validates :email, uniqueness: true, email_format: { message: 'has invalid format' }
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password]}

end
