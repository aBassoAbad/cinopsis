class BuscarController < ApplicationController
    def buscar
        if I18n.locale == :es
            @locale = "es-ES"
        else
            @locale = "en-EN"
        end
        response = RestClient.get("https://api.themoviedb.org/3/search/movie?api_key=54e1519f91f40d97ec2abbdf458545ac&query=#{params[:query]}&language=#{@locale}&include_adult=false")
        @peliculas = JSON.parse(response)["results"]
        response = RestClient.get("https://api.themoviedb.org/3/search/tv?api_key=54e1519f91f40d97ec2abbdf458545ac&query=#{params[:query]}&language=#{@locale}&include_adult=false")
        @series = JSON.parse(response)["results"]
    end
end