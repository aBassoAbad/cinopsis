class SessionsController < ApplicationController
    def new
    end

    def create
        usuario = Usuario.find_by(email: params[:sessions][:email].downcase)
        if usuario && usuario.authenticate(params[:sessions][:password])
            session[:usuario_id] = usuario.id
            flash[:success] = t(:bienvenido)+" "+usuario.nombre.capitalize
            redirect_to usuario
        else
            flash[:danger] = t(:no_inicio_sesion)
            render 'new'
        end
    end

    def destroy
        session[:usuario_id] = nil
        flash[:success] = t(:sesion_cerrada)
        redirect_to root_path
    end
end