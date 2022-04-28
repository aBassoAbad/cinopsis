class SessionsController < ApplicationController
    def new
    end

    def create
        usuario = Usuario.find_by(email: params[:sessions][:email].downcase)
        if usuario && usuario.authenticate(params[:sessions][:password])
            session[:usuario_id] = usuario.id
            redirect_to usuario
        else
            render 'new'
        end
    end

    def destroy
        session[:usuario_id] = nil
        redirect_to root_path
    end
end