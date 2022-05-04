class Usuario < ApplicationRecord
    before_save { self.email = email.downcase }

    validates :nombre, presence: true, length: {maximum: 50}
    EMAIL_VALIDO_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: {maximum: 250},
                        format: {with: EMAIL_VALIDO_REGEX},
                        uniqueness: {case_sensitive: false}
    has_secure_password
    validates :password, presence: true, length: {minimum:8}, allow_nil: true
    has_many :friendships, dependent: :destroy
    has_many :amigos, through: :friendships
    has_many :lists, dependent: :destroy
end