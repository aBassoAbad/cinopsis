ENV['RAILS_ENV'] ||= 'test'
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  # parallelize(workers: :number_of_processors, with: :threads)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def inicio_sesion(usuario, password)
    post login_path, params: { sessions: { email: usuario.email, password: password } }
  end

  def añadir_amigo(usuario)
    post anadir_amigos_usuario_path(usuario.id)
  end
end
