class PeliculasController < ApplicationController
    def index
        response = RestClient.get('https://pokeapi.co/api/v2/pokemon?limit=12')
        @pelicula = JSON.parse(response)
        response = RestClient.get('https://pokeapi.co/api/v2/pokemon?limit=12&offset=12')
        @peliculas = JSON.parse(response)
        #@peliculas = Pelicula.all.per(20)
    end

    def show
        @nombre = params[:id]
        response = RestClient.get("https://pokeapi.co/api/v2/pokemon/#{@nombre}")
        @peliculas = JSON.parse(response)
        @pelicula = Pelicula.first
        @equipo = @pelicula.personas.order(:departamento)
        @generos = @pelicula.generos
        @plataformas = @pelicula.plataformas
    end

    def series
        response = RestClient.get('https://pokeapi.co/api/v2/pokemon')
        @series = JSON.parse(response)
    end

    def new
    end

    def create
    end

    def destroy
    end

    
    private

    def pelicula_params
        params.require(:pelicula).permit(:nombre, :fecha_estreno, :sinopsis, :poster, :tipo)
    end
end