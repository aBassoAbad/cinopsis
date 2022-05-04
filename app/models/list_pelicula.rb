class ListPelicula < ApplicationRecord
    belongs_to :pelicula
    belongs_to :list
end