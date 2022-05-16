require "test_helper"

class UsuariosSignupTest < ActionDispatch::IntegrationTest
  test "debería acceder a la ruta de registro" do
    get registro_path
    assert_response :success 
  end

  test "rechaza un registro no válido" do
    get registro_path
    assert_no_difference "Usuario.count" do
      post usuarios_path, params: {usuario: {nombre: " ", email: " ", password: "contrasena", password_confirmation: " "} }
    end
    assert_template 'usuarios/new'
  end

  test "acepta un registro válido" do
    get registro_path  
    assert_difference "Usuario.count" do
      post usuarios_path, params: {usuario: {nombre: "prueba", email: "prueba@correo.com", password: "contrasena", password_confirmation: "contrasena"} }
    end
    assert_redirected_to root_path
  end
  
  test "crear una lista de vistos al crear un usuario" do
    get registro_path
    assert_difference "List.count" do
      post usuarios_path, params: {usuario: {nombre: "prueba", email: "prueba@correo.com", password: "contrasena", password_confirmation: "contrasena"} }
    end
  end
end
