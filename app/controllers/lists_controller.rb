class ListsController < ApplicationController
    before_action :necesario_mismo_usuario, only:[:edit, :update, :destroy]
    
    def listas
        @listas = List.where(usuario_id: params[:id])
    end

    def show
        @lista = List.find(params[:id])
    end

    def new
        @lista = List.new
    end

    def create
        @lista = List.new(lista_params)
        @lista.usuario = usuario_actual
        if @lista.save
            flash[:success] = t(:lista_creade)
            redirect_to listas_path(usuario_actual)
        else
            flash[:danger] = t(:lista_no_creada)
            render 'new'
        end
    end

    def destroy
        @lista = List.find(params[:id])
        if @lista.nombre_lista != "Vistos"
            @lista.destroy
            flash[:success] = t(:lista_borrada)
        else
            flash[:danger] = t(:lista_no_borrada)
        end
        redirect_to listas_path(usuario_actual)
    end

    def edit
        @lista = List.find(params[:id])
    end

    def update
        @lista = List.find(params[:id])
        if @lista.nombre_lista != "Vistos" && @lista.update(lista_params)
            flash[:success] = t(:lista_editada)
            redirect_to @lista
        else
            flash[:danger] = t(:lista_no_editada)
            render 'edit'
        end
    end

    def anadir_pelicula
        @lista = List.find(params[:id])
    end

    private 
    
    def lista_params
        params.require(:list).permit(:nombre_lista)
    end

    def necesario_mismo_usuario
        @usuario = Usuario.find(List.find(params[:id]).usuario_id)
        unless logged_in? && (usuario_actual == @usuario || usuario_actual.admin?)
            flash[:danger] = t(:accion_invalidada)
            redirect_to usuarios_path
        end
    end

    def necesario_admin
        if logged_in? & !usuario_actual.admin?
            flash[:danger] = t(:accion_invalidada)
            redirect_to root_path
        end
    end

    def necesario_loggeado
        if !logged_in?
            flash[:danger] = t(:accion_invalidada)
            redirect_to root_path
        end
    end
end