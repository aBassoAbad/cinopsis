class GeneroPelicula < ApplicationRecord
    belongs_to :genero 
    belongs_to :pelicula
end