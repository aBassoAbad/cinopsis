require "test_helper"

class ListsTest < ActionDispatch::IntegrationTest
  def setup 
    @usuario = Usuario.create!(nombre: "alejandro", email: "alejandro@correo.com", password: "contrasena")
    inicio_sesion(@usuario, 'contrasena')
    @lista = List.create(nombre_lista: "favoritas", usuario: @usuario)
    @lista2 = List.create(nombre_lista: "Vistos", usuario: @usuario)
    @pelicula = Pelicula.create(nombre: "Avatar", fecha_estreno: "18/12/2009",
                                sinopsis: "Pocahontas pero en el espacio", tipo: "pelicula")  
    @pelicula2 = Pelicula.create(nombre: "Terminator", fecha_estreno: "18/12/1984",
                                sinopsis: "Robot malo persigue a chica", tipo: "pelicula") 
    @lista.peliculas << @pelicula
    @lista.peliculas << @pelicula2
    @lista2.peliculas << @pelicula2
  end

  test "crea una lista nueva válida" do
    get new_list_path
    assert_template 'lists/new'
    assert_difference 'List.count', 1 do
      post lists_path, params: { list: { nombre_lista: "Nueva"}}
    end
  end
  
  test "no crea una lista nueva inválida" do
    get new_list_path
    assert_template 'lists/new'
    assert_no_difference 'List.count' do
      post lists_path, params: { list: { nombre_lista: " "}}
    end
    assert_template 'lists/new'
  end

  test "rechaza lista con el mismo nombre que otra del usuario" do
    get new_list_path
    assert_template 'lists/new'
    assert_no_difference 'List.count' do
      post lists_path, params: {list: {nombre_lista: "favoritas"}}
    end
    assert_template 'lists/new'
  end

end