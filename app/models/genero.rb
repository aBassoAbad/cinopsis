class Genero < ApplicationRecord
    validates :nombre, presence: true
    has_many :genero_peliculas
    has_many :peliculas, through: :genero_peliculas
end