class ListsController < ApplicationController
    def index
        @listas = List.where(usuario_id: usuario_actual.id).page(params[:page]).per(2)
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
            flash[:success] = "Se ha creado la lista correctamente"
            redirect_to list_path(@lista)
        else
            flash[:danger] = "No se ha podido crear la lista"
            render 'new'
        end
    end

    def destroy
        List.find(params[:id]).destroy
        flash[:success] = "Lista borrada correctamente"
        redirect_to lists_path
    end

    def edit
        @lista = List.find(params[:id])
    end

    def update
        @lista = List.find(params[:id])
        if @lista.update(lista_params)
            flash[:success] = "Se ha editado la lista correctamente"
            redirect_to @lista
        else
            flash[:danger] = "No se ha podido editar la lista"
            render 'edit'
        end
    end

    private 
    
    def lista_params
        params.require(:list).permit(:nombre_lista)
    end
end