require "test_helper"

class UsuariosShowTest < ActionDispatch::IntegrationTest
  def setup 
    @usuario = Usuario.create(nombre: "alejandro", email: "alejandro@correo.com", password: "contraseña")
  end

  test "accede al perfil" do
    get usuario_path(@usuario)
    assert_template 'usuarios/show'
  end
end
