class List < ApplicationRecord
    validates :nombre_lista, presence: true, :uniqueness => {:scope => :usuario_id}
    validates :usuario_id, presence: true
    belongs_to :usuario
    has_many :list_peliculas
    has_many :peliculas, through: :list_peliculas
end