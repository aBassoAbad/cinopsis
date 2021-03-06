require "test_helper"

class UsuariosListadoTest < ActionDispatch::IntegrationTest
  def setup
    @usuario = Usuario.create(nombre: "alejandro", email: "alejandro@correo.com", password: "contrasena")
    @usuario2 = Usuario.create(nombre: "manolo", email: "manolo@correo.com", password: "contrasena")
  end

  test "accede al listado de usuarios" do
    get usuarios_path
    assert_template 'usuarios/index'
    assert_select "a[href=?]", usuario_path(@usuario), text: @usuario.nombre.capitalize
    assert_select "a[href=?]", usuario_path(@usuario2), text: @usuario2.nombre.capitalize
  end

  test "añade amigo" do
    inicio_sesion(@usuario, "contrasena")
    get usuarios_path
    assert_template 'usuarios/index'
    assert_difference 'Friendship.count' do
      añadir_amigo(@usuario2)
    end
    assert_redirected_to root_path
  end

  test "borra amigo" do
    inicio_sesion(@usuario, "contrasena")
    get usuarios_path
    assert_template 'usuarios/index'
    assert_difference 'Friendship.count' do
      añadir_amigo(@usuario2)
    end
    assert_difference 'Friendship.count', -1 do
      borrar_amigo(@usuario2)
    end
    assert_redirected_to root_path
  end
end
