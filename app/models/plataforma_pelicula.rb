class PlataformaPelicula < ApplicationRecord
    belongs_to :plataforma
    belongs_to :pelicula
end