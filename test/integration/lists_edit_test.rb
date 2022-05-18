require "test_helper"

class ListsEditTest < ActionDispatch::IntegrationTest
  def setup
    @usuario = Usuario.create!(nombre: "alejandro", email: "alejandro@correo.com", password: "contrasena")
    inicio_sesion(@usuario, 'contrasena')
    @lista = List.create(nombre_lista: "favoritas", usuario: @usuario)
    @lista2 = List.create(nombre_lista: "vistas", usuario: @usuario)
  end

  test "edita una lista válida" do
    get edit_list_path(@lista)
    assert_template 'lists/edit'
    nombre_nuevo = "Editada"
    patch list_path(@lista), params: {list: {nombre_lista: nombre_nuevo}}
    assert_redirected_to @lista
    assert_not flash.empty?
    @lista.reload
    assert_match nombre_nuevo, @lista.nombre_lista    
  end

  test "rechaza editar lista no válida" do
    get edit_list_path(@lista)
    assert_template 'lists/edit'
    nombre_nuevo = " "
    patch list_path(@lista), params: {list: {nombre_lista: nombre_nuevo}}
    assert_template 'edit'
    assert_not flash.empty?
  end

  test "rechaza lista con el mismo nombre que otra del usuario" do
    get edit_list_path(@lista)
    assert_template 'lists/edit'
    assert_no_difference 'List.count' do
      patch list_path(@lista), params: {list: {nombre_lista: "vistas"}}
    end
    assert_template 'lists/edit'
    assert_not flash.empty?
  end
end
