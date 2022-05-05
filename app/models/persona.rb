class Persona < ApplicationRecord
    has_many :persona_peliculas
    has_many :peliculas, through: :persona_peliculas
end