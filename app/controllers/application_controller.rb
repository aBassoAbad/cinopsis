class ApplicationController < ActionController::Base  
    before_action :set_locale
    helper_method :usuario_actual, :logged_in?

    def usuario_actual
        @usuario_actual ||= Usuario.find(session[:usuario_id]) if session[:usuario_id]
    end

    def logged_in?
        !!usuario_actual
    end

    def require_user
        if !logged_in?
            redirect_to root_path
        end
    end

    private
    def set_locale
      I18n.locale = "es"
    end

end
