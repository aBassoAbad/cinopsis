class Plataforma < ApplicationRecord
    validates :nombre, presence: true
    has_many :plataforma_peliculas
    has_many :peliculas, through: :plataforma_peliculas
end