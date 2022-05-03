class Friendship < ApplicationRecord
    belongs_to :usuario
    belongs_to :amigo, class_name: "Usuario"
    
    validates_uniqueness_of :usuario, scope: :amigo

    def self.create_reciprocal_for_ids(usuario_id, amigo_id)
        usuario_friendship = Friendship.create(usuario_id: usuario_id, amigo_id: amigo_id)
        amigo_friendship = Friendship.create(usuario_id: amigo_id, amigo_id: usuario_id)
        [usuario_friendship, amigo_friendship]
    end

    def self.destroy_reciprocal_for_ids(usuario_id, amigo_id)
        friendship1 = Friendship.find_by(usuario_id: usuario_id, amigo_id: amigo_id)
        friendship2 = Friendship.find_by(usuario_id: amigo_id, amigo_id: usuario_id)
        friendship1.destroy
        friendship2.destroy
    end
end
