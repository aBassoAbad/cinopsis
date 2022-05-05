class PeliculasController < ApplicationController
    def index
        #response = RestClient.get('https://pokeapi.co/api/v2/pokemon')
        #@pelicula = JSON.parse(response)
    end

    def new
        @pelicula = Pelicula.new
    end

    def create
        @pelicula = Pelicula.new(pelicula_params)
        if @pelicula.save
            @plataforma = Plataforma.create(nombre: )
            redirect_to usuario_path(@usuario)
        else
            render 'new'
        end
    end

    private

    def pelicula_params
        params.require(:pelicula).permit(:nombre, :fecha_estreno, :sinopsis, :poster, :tipo)
    end
end