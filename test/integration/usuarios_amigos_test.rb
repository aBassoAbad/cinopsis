require "test_helper"

class UsuariosAmigosTest < ActionDispatch::IntegrationTest
  def setup
    @usuario = Usuario.create(nombre: "alejandro", email: "alejandro@correo.com", password: "contrasena")
    @usuario2 = Usuario.create(nombre: "manolo", email: "manolo@correo.com", password: "contrasena")
  end

  test "deberia añadir amigos" do
    inicio_sesion(@usuario, "contrasena")
    get usuarios_path
    assert_template 'usuarios/index'
    assert_difference 'Friendship.count' do
      añadir_amigo(@usuario2)
    end
    assert_redirected_to root_path
  end

  test "deberia borrar de amigos" do
    inicio_sesion(@usuario, "contrasena")
    get amigos_path
    assert_template 'friendships/index'
    assert_difference 'Friendship.count' do
      añadir_amigo(@usuario2)
    end
    assert_difference 'Friendship.count', -1 do
      borrar_amigo(@usuario2)
    end
    assert_redirected_to root_path
  end

  test "debería ir al perfil del amigo" do
    inicio_sesion(@usuario, "contrasena")
    añadir_amigo(@usuario2)
    get amigos_path
    assert_template 'friendships/index'
    assert_select "a[href=?]", usuario_path(@usuario2), text: @usuario2.nombre.capitalize
  end
end
