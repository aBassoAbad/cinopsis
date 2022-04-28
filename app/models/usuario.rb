class Usuario < ApplicationRecord
    before_save { self.email = email.downcase }
    
    validates :nombre, presence: true, length: {maximum: 50}
    EMAIL_VALIDO_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: {maximum: 250},
                        format: {with: EMAIL_VALIDO_REGEX},
                        uniqueness: {case_sensitive: false}
end