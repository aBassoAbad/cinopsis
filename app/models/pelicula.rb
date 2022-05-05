class Pelicula < ApplicationRecord
    validates :nombre, presence: true
    validates :fecha_estreno, presence: true
    validates :sinopsis, presence: true, length:{minimum: 5}
    validates :tipo, inclusion: { in: %w(pelicula serie), 
        message: "Debe ser pelicula o serie"}
    has_many :list_peliculas
    has_many :lists, through: :list_peliculas
    has_many :genero_peliculas
    has_many :generos, through: :genero_peliculas
    has_many :plataforma_peliculas
    has_many :plataformas, through: :plataforma_peliculas
    has_many :persona_peliculas
    has_many :personas, through: :persona_peliculas
end