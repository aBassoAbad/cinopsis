class PeliculasController < ApplicationController
    def index
        lista = List.where(usuario_id: usuario_actual.id)
        @peliculas = Peliculas.where(lists: lista)
    end
end