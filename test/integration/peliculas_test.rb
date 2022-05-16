require "test_helper"

class PeliculasTest < ActionDispatch::IntegrationTest
  def setup
    @pelicula = Pelicula.create(nombre: "Avatar", fecha_estreno: "18/12/2009",
                                sinopsis: "Pocahontas pero en el espacio", tipo: "pelicula")  
    @pelicula2 = Pelicula.create(nombre: "Terminator", fecha_estreno: "18/12/1984",
                            sinopsis: "Robot malo persigue a chica", tipo: "pelicula")  
  end

  test "muestra la lista de películas" do
    get peliculas_path
    assert_template 'peliculas/index'
  end
end
