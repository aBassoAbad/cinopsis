class PeliculasController < ApplicationController
    def index
        response = RestClient.get('https://api.themoviedb.org/3/movie/popular?api_key=54e1519f91f40d97ec2abbdf458545ac&language=es-ES')
        @populares = JSON.parse(response)
        
        response = RestClient.get('https://api.themoviedb.org/3/movie/top_rated?api_key=54e1519f91f40d97ec2abbdf458545ac&language=es-ES')
        @mejor_valoradas = JSON.parse(response)
    end

    def show
        @id = params[:id]
        response = RestClient.get("https://api.themoviedb.org/3/movie/#{@id}?api_key=54e1519f91f40d97ec2abbdf458545ac&language=es-ES")
        @detalles = JSON.parse(response)
        
        response = RestClient.get("https://api.themoviedb.org/3/movie/#{@id}/credits?api_key=54e1519f91f40d97ec2abbdf458545ac&language=es-ES")
        @equipo = JSON.parse(response)["cast"]
        
        response = RestClient.get("https://api.themoviedb.org/3/movie/#{@id}/watch/providers?api_key=54e1519f91f40d97ec2abbdf458545ac&language=es-ES")
        begin
            @providers = JSON.parse(response)["results"]["ES"]["flatrate"]
        rescue
            @providers = ""
        end

        response = RestClient.get("https://api.themoviedb.org/3/movie/#{@id}/videos?api_key=54e1519f91f40d97ec2abbdf458545ac&language=es-ES")
        @video = JSON.parse(response)
    end

    def new
    end

    def create
    end

    def destroy
    end

    def buscar
        response = RestClient.get("https://api.themoviedb.org/3/search/movie?api_key=54e1519f91f40d97ec2abbdf458545ac&query=#{params[:query]}&language=es-ES&include_adult=false")
        @peliculas = JSON.parse(response)["results"]
        response = RestClient.get("https://api.themoviedb.org/3/search/tv?api_key=54e1519f91f40d97ec2abbdf458545ac&query=#{params[:query]}&language=es-ES&include_adult=false")
        @series = JSON.parse(response)["results"]
    end

    
    private

    def pelicula_params
        params.require(:pelicula).permit(:nombre, :fecha_estreno, :sinopsis, :poster, :tipo)
    end
end