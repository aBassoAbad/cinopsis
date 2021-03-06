require "test_helper"

class ListsDeleteTest < ActionDispatch::IntegrationTest
  def setup
    @usuario = Usuario.create!(nombre: "alejandro", email: "alejandro@correo.com", password: "contrasena")
    inicio_sesion(@usuario, 'contrasena')
    @lista = List.create(nombre_lista: "favoritas", usuario: @usuario)
    @lista2 = List.create(nombre_lista: "Vistos", usuario: @usuario)
  end

  test "borra una lista correctamente" do
    get lists_path
    assert_template 'lists/index'
    assert_difference 'List.count', -1 do
      delete list_path(@lista)
    end
    assert_redirected_to lists_path
    assert_not flash.empty?
  end

  test "no permite borrar la lista Vistos" do
    assert_no_difference 'List.count' do
      delete list_path(@lista2)
    end
    assert_redirected_to lists_path
    assert_not flash.empty?
  end
end
