class UsuariosController < ApplicationController
    
    def new
        @usuario = Usuario.new
    end

    def create
        @usuario = Usuario.new(usuario_params)
        if @usuario.save
            redirect_to usuario_path(@usuario)
        else
            render 'new'
        end
    end

    def show
        @usuario = Usuario.find(params[:id])
    end

    def edit
        @usaurio = Usuario.find(params[:id])
    end

    def update
        @usaurio = Usuario.find(params[:id])
        if @usuario.update(usuario_params)
            redirect_to @usuario
        else
            render 'edit'
        end
    end

    def index
        @usuarios = Usuario.all
    end

    private 
    
    def usuario_params
        params.require(:usuario).permit(:nombre, :email, :password, :password_confirmation)
    end
end