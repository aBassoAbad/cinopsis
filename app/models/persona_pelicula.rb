class PersonaPelicula < ApplicationRecord
    belongs_to :persona
    belongs_to :pelicula
end