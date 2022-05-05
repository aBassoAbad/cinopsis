class Persona < ApplicationRecord
    validates :nombre, presence: true
    validates :departamento, presence: true
    has_many :persona_peliculas
    has_many :peliculas, through: :persona_peliculas
end