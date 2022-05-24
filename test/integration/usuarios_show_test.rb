require "test_helper"

class UsuariosShowTest < ActionDispatch::IntegrationTest
  def setup 
    @usuario = Usuario.create(nombre: "alejandro", email: "alejandro@correo.com", password: "contrasena")
    @usuario2 = Usuario.create(nombre: "manolo", email: "manolo@correo.com", password: "contrasena")
  end

  test "accede al perfil de un usuario cuando no está logueado" do
    get usuario_path(@usuario)
    assert_template 'usuarios/show'
    assert_select "a[href=?]", lists_path, text: "Listas" || "Lists"
    assert_select "a[href=?]", amigos_path
    assert_select "a[href=?]", anadir_amigos_usuario_path(@usuario), count: 0
    assert_select "a[href=?]", borrar_amigos_usuario_path(@usuario), count: 0
  end

  test "accede a su perfil cuando está logueado" do
    inicio_sesion(@usuario, "contrasena")
    get usuario_path(@usuario)
    assert_template 'usuarios/show'
    assert_select "a[href=?]", lists_path
    assert_select "a[href=?]", amigos_path
    assert_select "a[href=?]", anadir_amigos_usuario_path(@usuario), count: 0
    assert_select "a[href=?]", borrar_amigos_usuario_path(@usuario), count: 0
  end

  test "accede al perfil de otro usuario cuando está logueado" do
    inicio_sesion(@usuario, "contrasena")
    get usuario_path(@usuario2)
    assert_template 'usuarios/show'
    assert_select "a[href=?]", lists_path
    assert_select "a[href=?]", amigos_path
    assert_select "a[href=?]", anadir_amigos_usuario_path(@usuario2)
    assert_select "a[href=?]", borrar_amigos_usuario_path(@usuario2), count: 0
    assert_difference 'Friendship.count' do
      añadir_amigo(@usuario2)
    end
    assert_redirected_to root_path
    assert_not flash.empty?
  end
  

  test "accede al perfil de un amigo cuando está logueado" do
    inicio_sesion(@usuario, "contrasena")
    añadir_amigo(@usuario2)
    get usuario_path(@usuario2)
    assert_template 'usuarios/show'
    assert_select "a[href=?]", lists_path
    assert_select "a[href=?]", amigos_path
    assert_select "a[href=?]", anadir_amigos_usuario_path(@usuario2), count: 0
    assert_select "a[href=?]", borrar_amigos_usuario_path(@usuario2)
    assert_difference 'Friendship.count', -1 do
      borrar_amigo(@usuario2)
    end
    assert_redirected_to root_path
    assert_not flash.empty?
  end
end
