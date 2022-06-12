class FriendshipsController < ApplicationController
    protect_from_forgery with: :exception
    before_action :necesario_mismo_usuario_o_admin, only:[:destroy]

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

    def amigos
      @usuario = Usuario.find(params[:id])
      @amigos = Usuario.find(params[:id]).amigos     
    end

    private

    def necesario_mismo_usuario_o_admin
      unless logged_in? && (usuario_actual == @usuario || usuario_actual.admin?)
          flash[:danger] = t(:accion_invalidada)
          redirect_to usuarios_path
      end
  end
end