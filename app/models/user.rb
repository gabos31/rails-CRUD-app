class User < ApplicationRecord
  validates :password, length: { in: 4..20, message: 'Minimum password length is 4 characters' },
                       allow_blank: true
  validates :email, uniqueness: { message: 'User with this email is already exist' },
                    format: { with: URI::MailTo::EMAIL_REGEXP, message: "Your email isn't valid" }

  has_secure_password

  def full_name
    "#{first_name} #{last_name}"
  end
end
