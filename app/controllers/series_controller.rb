class SeriesController < ApplicationController
    def show
        @listas_usuario = usuario_actual.lists
        @pelicula = Pelicula.find_by(id_tmdb: params[:id])
        if @pelicula
            @listas = @pelicula.lists.where(usuario_id: usuario_actual.id)
        else
            @listas = {}
        end
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

    def anadir_a_lista
        @lista = List.find(params["id_lista"])
        @pelicula = Pelicula.find_by(id_tmdb: params["id"])
        unless @pelicula
            @pelicula = Pelicula.create(nombre: params["name"], fecha_estreno: params["first_air_date"], sinopsis: params["overview"],
                                        poster: params["poster_path"], tipo: "serie", id_tmdb: params["id"])
        end
        ListPelicula.find_or_create_by(pelicula_id: @pelicula.id, list_id: @lista.id)
        redirect_back(fallback_location: root_path)
    end

    def borrar_de_lista
        @lista = List.find(params["id_lista"])
        @pelicula = Pelicula.find_by(id_tmdb: params["id"])
        unless @pelicula
            @pelicula = Pelicula.create(nombre: params["name"], fecha_estreno: params["release_date"], sinopsis: params["overview"],
                                        poster: params["poster_path"], tipo: "serie", id_tmdb: params["id"])
        end
        ListPelicula.find_by(pelicula_id: @pelicula.id, list_id: @lista.id).delete()
        redirect_back(fallback_location: root_path)
    end
end