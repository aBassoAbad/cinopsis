require "test_helper"

class UsuariosLoginTest < ActionDispatch::IntegrationTest
  def setup 
    @usuario = Usuario.create(nombre: "antonio", email: "antonio@correo.com", password: "contrasena")
  end

  test "rechaza login no válido" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: {sessions: {email: " ", password: " "}}
    assert_template 'sessions/new'
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", registro_path
    assert_select "a[href=?]", logout_path, count: 0
  end

  test "acepta las credenciales y login válido" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: {sessions: {email: @usuario.email, password: @usuario.password}}
    assert_redirected_to @usuario
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", registro_path, count: 0
  end
end
