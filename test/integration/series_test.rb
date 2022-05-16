require "test_helper"

class SeriesTest < ActionDispatch::IntegrationTest
  def setup
    serie = Pelicula.create(nombre: "Peaky Blinders", fecha_estreno: "2-2-2018",
                            sinopsis: "Banda en Inglaterra", tipo: "serie")
    serie2 = Pelicula.create(nombre: "Los Simpsons", fecha_estreno: "1-1-1985",
                            sinopsis: "Familia americana, pero son amarillos", tipo: "serie")
  end

  test "Dirige a la página de series" do
    get series_path
    assert_template "peliculas/series"
  end
end
