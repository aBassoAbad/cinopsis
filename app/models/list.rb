class List < ApplicationRecord
    validates :nombre_lista, presence: true
    validates :usuario_id, presence: true
    belongs_to :usuario
end