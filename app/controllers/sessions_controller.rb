class SessionsController < ApplicationController
    def new
    end

    def create
        usuario = Usuario.find_by(email: params[:sessions][:email].downcase)
        if usuario && usuario.authenticate(params[:sessions][:password])
            session[:usuario_id] = usuario.id
            flash[:success] = "Bienvenid@ de nuevo #{usuario.nombre.capitalize}"
            redirect_to usuario
        else
            flash[:danger] = "No se ha podido iniciar sesión"
            render 'new'
        end
    end

    def destroy
        session[:usuario_id] = nil
        flash[:success] = "Has cerrado sesión correctamente"
        redirect_to root_path
    end
end