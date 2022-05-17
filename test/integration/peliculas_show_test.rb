require "test_helper"

class PeliculasShowTest < ActionDispatch::IntegrationTest
  def setup
    @pelicula = Pelicula.create(nombre: "Avatar", fecha_estreno: "18-12-2009",
                                sinopsis: "Pocahontas en el espacio", tipo: "pelicula")
  end

  test "accede a la página correctamente" do
    get pelicula_path(@pelicula)
    assert_template 'peliculas/show'
  end
end
