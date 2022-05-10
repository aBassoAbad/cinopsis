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
            flash[:success] = "Te has registrado correctamente"
            redirect_to root_path
        else
            @usuario.errors.each do |msg|
                flash[:danger] = msg.full_message
            end
            render 'new'
        end
    end

    def show
    end

    def edit
    end

    def update
        if @usuario.update(usuario_params)
            flash[:success] = "Se ha editado el usuario correctamente"
            redirect_to @usuario
        else
            flash[:danger] = "No se ha podido editar el usuario"
            render 'edit'
        end
    end

    def index
        @usuarios = Usuario.all
    end

    def anadir_amigos
        amigos = Friendship.create(usuario_id: usuario_actual.id, amigo_id: params[:id])
        flash[:success] = "#{Usuario.find(params[:id]).nombre.capitalize} se ha añadido a amigos"
        redirect_back(fallback_location: root_path)
    end

    def borrar_amigos
        amigos = Friendship.delete_by(usuario_id: usuario_actual.id, amigo_id: params[:id])
        flash[:success] = "#{Usuario.find(params[:id]).nombre.capitalize} se ha borrado de amigos"
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
        if usuario_actual != @usuario
            flash[:danger] = "No puedes realizar esa acción"
            redirect_to usuarios_path
        end
    end

    def necesario_admin
        if logged_in? & !usuario_actual.admin?
            flash[:danger] = "No puedes realizar esa acción"
            redirect_to root_path
        end
    end
end