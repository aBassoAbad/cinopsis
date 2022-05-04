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
            redirect_to list_path(@lista)
        else
            render 'new'
        end
    end

    def destroy
        List.find(params[:id]).destroy
        redirect_to lists_path
    end

    def edit
        @lista = List.find(params[:id])
    end

    def update
        @lista = List.find(params[:id])
        if @lista.update(lista_params)
            redirect_to @lista
        else
            render 'edit'
        end
    end

    private 
    
    def lista_params
        params.require(:list).permit(:nombre_lista)
    end
end