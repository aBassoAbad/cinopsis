class UsuariosController < ApplicationController
    before_action :set_usuario, only:[:show, :edit, :update, :destroy]
    before_action :necesario_mismo_usuario_o_admin, only:[:edit, :update, :destroy]
    before_action :necesario_admin, only:[:new_admin, :crear_admin]
    def new
        @usuario = Usuario.new
    end

    def create
        @usuario = Usuario.new(usuario_params)
        if @usuario.save
            @lista = List.create(nombre_lista: "Vistos", usuario_id: @usuario.id)
            flash[:success] = t(:registro_correcto)
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
            flash[:success] = t(:edicion_usuario_correcto)
            redirect_to @usuario
        else
            flash[:danger] = t(:edicion_usuario_error)
            render 'edit'
        end
    end

    def index
        @usuarios = Usuario.all
    end

    def anadir_amigos
        amigos = Friendship.create(usuario_id: usuario_actual.id, amigo_id: params[:id])
        flash[:success] = Usuario.find(params[:id]).nombre.capitalize+ t(:anadido_a_amigos)
        redirect_back(fallback_location: root_path)
    end

    def borrar_amigos
        amigos = Friendship.delete_by(usuario_id: usuario_actual.id, amigo_id: params[:id])
        flash[:success] = Usuario.find(params[:id]).nombre.capitalize+ t(:borrado_de_amigos)
        redirect_back(fallback_location: root_path)
    end

    def new_admin
        @usuario = Usuario.new
    end

    def crear_admin
        @usuario = Usuario.new(usuario_params, admin: true)
        if @usuario.save
            @usuario.admin = true
            @usuario.save
            @lista = List.create(nombre_lista: "Vistos", usuario_id: @usuario.id)
            flash[:success] = t(:registro_correcto)
            redirect_to root_path
        else
            @usuario.errors.each do |msg|
                flash[:danger] = msg.full_message
            end
            render 'new_admin'
        end
    end

    def hacer_admin
        @usuario = Usuario.find(params["id"])
        if @usuario
            @usuario.admin = true
            @usuario.save
        end
        redirect_back(fallback_location: root_path)
    end

    def quitar_admin
        @usuario = Usuario.find(params["id"])
        if @usuario
            @usuario.admin = false
            @usuario.save
        end
        redirect_back(fallback_location: root_path)
    end

    private 
    
    def usuario_params
        params.require(:usuario).permit(:nombre, :email, :password, :password_confirmation, :admin)
    end

    def set_usuario
        @usuario = Usuario.find(params[:id])
    end
    
    def necesario_mismo_usuario_o_admin
        unless logged_in? && (usuario_actual == @usuario || usuario_actual.admin?)
            flash[:danger] = t(:accion_invalidada)
            redirect_to usuarios_path
        end
    end

    def necesario_admin
        unless logged_in? && usuario_actual.admin?
            flash[:danger] = t(:accion_invalidada)
            redirect_to root_path
        end
    end
end