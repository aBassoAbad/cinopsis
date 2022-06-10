class SeriesController < ApplicationController
    def show
        if I18n.locale == :es
            @locale = "es-ES"
        else
            @locale = "en-EN"
        end
        @id = params[:id]
        response = RestClient.get("https://api.themoviedb.org/3/tv/#{@id}?api_key=54e1519f91f40d97ec2abbdf458545ac&language=#{@locale}")
        @detalles = JSON.parse(response)
        
        response = RestClient.get("https://api.themoviedb.org/3/tv/#{@id}/credits?api_key=54e1519f91f40d97ec2abbdf458545ac&language=#{@locale}")
        @equipo = JSON.parse(response)["cast"]
        
        response = RestClient.get("https://api.themoviedb.org/3/tv/#{@id}/watch/providers?api_key=54e1519f91f40d97ec2abbdf458545ac&language=#{@locale}")
        begin
            @providers = JSON.parse(response)["results"]["ES"]["flatrate"]
        rescue
            @providers = ""
        end

        response = RestClient.get("https://api.themoviedb.org/3/tv/#{@id}/videos?api_key=54e1519f91f40d97ec2abbdf458545ac&language=#{@locale}")
        @video = JSON.parse(response)
    end
    
    def index  
        if I18n.locale == :es
            @locale = "es-ES"
        else
            @locale = "en-EN"
        end    
        response = RestClient.get("https://api.themoviedb.org/3/tv/popular?api_key=54e1519f91f40d97ec2abbdf458545ac&language=#{@locale}")
        @populares = JSON.parse(response)
        
        response = RestClient.get("https://api.themoviedb.org/3/tv/top_rated?api_key=54e1519f91f40d97ec2abbdf458545ac&language=#{@locale}")
        @mejor_valoradas = JSON.parse(response)
    end
end