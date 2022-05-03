class FriendshipsController < ApplicationController
    protect_from_forgery with: :exception

    def create
        if params.include?(:amigo_id) 
            @new_friendships = Friendship.create_reciprocal_for_ids(usuario_actual.id, params[:amigo_id])
        else
          params[:usuario][:amigo_ids].each do |f_id|
            @new_friendships = Friendship.create_reciprocal_for_ids(usuario_actual.id, f_id)
          end
        end
        redirect_to usuario_path
    end

    def destroy
        Friendship.destroy_reciprocal_for_ids(usuario_actual.id, params[:amigo_id])
        redirect_to(request.referer)
    end

    def index
      @amigos = usuario_actual.amigos     
    end
end