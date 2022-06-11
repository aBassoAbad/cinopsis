class ListsController < ApplicationController
    def index
        @listas = List.where(usuario_id: usuario_actual.id)
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
            redirect_to lists_path
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
        redirect_to lists_path
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
end