require "test_helper"

class ListsTest < ActionDispatch::IntegrationTest
  def setup 
    @usuario = Usuario.create!(nombre: "alejandro", email: "alejandro@correo.com", password: "contrasena")
    inicio_sesion(@usuario, 'contrasena')
    @lista = List.create(nombre_lista: "favoritas", usuario: @usuario)
    @lista2 = List.create(nombre_lista: "vistas", usuario: @usuario)
  end

  test "debería dirigir a las listas del usuario" do
    get lists_path
    assert_response :success
  end

  test "debería mostrar las listas del usuario" do
    get lists_path
    assert_template 'lists/index'
    assert_select "a[href=?]", list_path(@lista), text: @lista.nombre_lista.capitalize
    assert_select "a[href=?]", edit_list_path(@lista), text: "Editar lista"
    assert_select "a[href=?]", list_path(@lista2), text: @lista2.nombre_lista.capitalize
    assert_select "a[href=?]", edit_list_path(@lista2), text: "Editar lista"
  end

  test "crea una lista nueva válida" do
    get new_list_path
    assert_template 'lists/new'
    assert_difference 'List.count', 1 do
      post lists_path, params: { list: { nombre_lista: "Nueva"}}
    end
    follow_redirect!
  end
  
  test "no crea una lista nueva inválida" do
    get new_list_path
    assert_template 'lists/new'
    assert_no_difference 'List.count' do
      post lists_path, params: { list: { nombre_lista: " "}}
    end
    assert_template 'lists/new'
  end
end