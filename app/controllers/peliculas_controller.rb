class PeliculasController < ApplicationController
    def index
        response = RestClient.get('https://pokeapi.co/api/v2/pokemon')
        @pelicula = JSON.parse(response)
        #@peliculas = Pelicula.all.per(20)
    end

    def show

    end

    def series
        response = RestClient.get('https://pokeapi.co/api/v2/pokemon')
        @series = JSON.parse(response)
    end

    private

    def pelicula_params
        params.require(:pelicula).permit(:nombre, :fecha_estreno, :sinopsis, :poster, :tipo)
    end
end