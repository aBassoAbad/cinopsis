class Pelicula < ApplicationRecord
    validates :nombre, presence: true
    validates :fecha_estreno, presence: true
    validates :sinopsis, presence: true, length:{minimum: 5}
end