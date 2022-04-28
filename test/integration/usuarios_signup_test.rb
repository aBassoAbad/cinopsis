require "test_helper"

class UsuariosSignupTest < ActionDispatch::IntegrationTest
  test "debería acceder a la ruta de registro" do
    get registro_path
    assert_response :success
  end
end
