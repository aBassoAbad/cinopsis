class UsuariosController < ApplicationController
    before_action :set_usuario, only:[:show, :edit, :update, :destroy]
    before_action :necesario_admin, only:[:destroy]
    before_action :necesario_mismo_usuario, only:[:edit, :update, :destroy]
    def new
        @usuario = Usuario.new
    end

    def create
        @usuario = Usuario.new(usuario_params)
        if @usuario.save
            @lista = List.create(nombre_lista: "Vistos", usuario_id: @usuario.id)
            redirect_to root_path
        else
            render 'new'
        end
    end

    def show
    end

    def edit
    end

    def update
        if @usuario.update(usuario_params)
            redirect_to @usuario
        else
            render 'edit'
        end
    end

    def index
        @usuarios = Usuario.all
    end

    def anadir_amigos
        amigos = Friendship.create(usuario_id: usuario_actual.id, amigo_id: params[:id])
        redirect_back(fallback_location: root_path)
    end

    def borrar_amigos
        amigos = Friendship.delete_by(usuario_id: usuario_actual.id, amigo_id: params[:id])
        redirect_back(fallback_location: root_path)
    end

    private 
    
    def usuario_params
        params.require(:usuario).permit(:nombre, :email, :password, :password_confirmation)
    end

    def set_usuario
        @usuario = Usuario.find(params[:id])
    end
    
    def necesario_mismo_usuario
        if current_chef != @chef
            redirect_to chefs_path
        end
    end

    def necesario_admin
        if logged_in? & !current_chef.admin?
            redirect_to root_path
        end
    end

end