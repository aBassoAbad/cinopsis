class PaginasController < ApplicationController
    def home
        redirect_to usuario_path(session[:usuario_id]) if logged_in?
    end
end