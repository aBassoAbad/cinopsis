class PeliculasController < ApplicationController
    def index
        if I18n.locale == :es
            @locale = "es-ES"
        else
            @locale = "en-EN"
        end
            response = RestClient.get("https://api.themoviedb.org/3/movie/popular?api_key=54e1519f91f40d97ec2abbdf458545ac&language=#{@locale}")
            @populares = JSON.parse(response)
            
            response = RestClient.get("https://api.themoviedb.org/3/movie/top_rated?api_key=54e1519f91f40d97ec2abbdf458545ac&language=#{@locale}")
            @mejor_valoradas = JSON.parse(response)
    end

    def show
        if logged_in?
            @listas_usuario = usuario_actual.lists
        else
            @listas_usuario = {}
        end
        @pelicula = Pelicula.find_by(id_tmdb: params[:id])
        if @pelicula && logged_in?
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
        unless @id
            @id = params["id"]
        end
        response = RestClient.get("https://api.themoviedb.org/3/movie/#{@id}?api_key=54e1519f91f40d97ec2abbdf458545ac&language=#{@locale}")
        @detalles = JSON.parse(response)
        
        response = RestClient.get("https://api.themoviedb.org/3/movie/#{@id}/credits?api_key=54e1519f91f40d97ec2abbdf458545ac&language=#{@locale}")
        @equipo = JSON.parse(response)["cast"]
        
        response = RestClient.get("https://api.themoviedb.org/3/movie/#{@id}/watch/providers?api_key=54e1519f91f40d97ec2abbdf458545ac&language=#{@locale}")
        begin
            @providers = JSON.parse(response)["results"]["ES"]["flatrate"]
        rescue
            @providers = ""
        end

        response = RestClient.get("https://api.themoviedb.org/3/movie/#{@id}/videos?api_key=54e1519f91f40d97ec2abbdf458545ac&language=#{@locale}")
        @video = JSON.parse(response)
    end

    def new
    end

    def create
        @usuario = Usuario.new(usuario_params)
        if @usuario.save
            @lista = List.create(nombre_lista: "Vistos", usuario_id: @usuario.id)
            flash[:success] = t(:registro_correcto)
            redirect_to root_path
        else
            @usuario.errors.each do |msg|
                flash[:danger] = msg.full_message
            end
            render 'new'
        end
    end

    def destroy
    end

    

    def anadir_a_lista
        @lista = List.find(params["id_lista"])
        @pelicula = Pelicula.find_by(id_tmdb: params["id"])
        unless @pelicula
            @pelicula = Pelicula.create(nombre: params["title"], fecha_estreno: params["release_date"], sinopsis: params["overview"],
                                        poster: params["poster_path"], tipo: "pelicula", id_tmdb: params["id"])
        end
        ListPelicula.find_or_create_by(pelicula_id: @pelicula.id, list_id: @lista.id)
        redirect_back(fallback_location: root_path)
    end

    def borrar_de_lista
        @lista = List.find(params["id_lista"])
        @pelicula = Pelicula.find_by(id_tmdb: params["id"])
        unless @pelicula
            @pelicula = Pelicula.create(nombre: params["title"], fecha_estreno: params["release_date"], sinopsis: params["overview"],
                                        poster: params["poster_path"], tipo: "pelicula", id_tmdb: params["id"])
        end
        ListPelicula.find_by(pelicula_id: @pelicula.id, list_id: @lista.id).delete()
        redirect_back(fallback_location: root_path)
    end
    private

    def pelicula_params
        params.permit(:nombre, :fecha_estreno, :sinopsis, :poster, :tipo, :id_tmdb)
    end
end