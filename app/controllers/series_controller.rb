class SeriesController < ApplicationController
    def show
        @id = params[:id]
        response = RestClient.get("https://api.themoviedb.org/3/tv/#{@id}?api_key=54e1519f91f40d97ec2abbdf458545ac&language=es-ES")
        @detalles = JSON.parse(response)
        
        response = RestClient.get("https://api.themoviedb.org/3/tv/#{@id}/credits?api_key=54e1519f91f40d97ec2abbdf458545ac&language=es-ES")
        @equipo = JSON.parse(response)["cast"]
        
        response = RestClient.get("https://api.themoviedb.org/3/tv/#{@id}/watch/providers?api_key=54e1519f91f40d97ec2abbdf458545ac&language=es-ES")
        begin
            @providers = JSON.parse(response)["results"]["ES"]["flatrate"]
        rescue
            @providers = ""
        end

        response = RestClient.get("https://api.themoviedb.org/3/tv/#{@id}/videos?api_key=54e1519f91f40d97ec2abbdf458545ac&language=es-ES")
        @video = JSON.parse(response)
    end
    
    def index      
        response = RestClient.get('https://api.themoviedb.org/3/tv/popular?api_key=54e1519f91f40d97ec2abbdf458545ac&language=es-ES')
        @populares = JSON.parse(response)
        
        response = RestClient.get('https://api.themoviedb.org/3/tv/top_rated?api_key=54e1519f91f40d97ec2abbdf458545ac&language=es-ES')
        @mejor_valoradas = JSON.parse(response)
    end
end