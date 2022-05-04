class Pelicula < ApplicationRecord
    validates :nombre, presence: true
    validates :fecha_estreno, presence: true
    validates :sinopsis, presence: true, length:{minimum: 5}
    has_many :list_peliculas
    has_many :lists, through: :list_peliculas
end