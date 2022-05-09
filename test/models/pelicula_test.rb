require 'test_helper'

class PeliculaTest < ActiveSupport::TestCase
    def setup
        @pelicula = Pelicula.new(nombre: "Avatar", fecha_estreno: "28-4-2022",
                                sinopsis: "Pocahontas en el espacio y con bichos azules muy altos",
                                poster: "", tipo: "pelicula")
    end

    test "la pelicula debería ser válida" do
        assert @pelicula.valid?
        @pelicula.tipo = "serie"
        assert @pelicula.valid?
    end

    test "la pelicula debe tener nombre" do
        @pelicula.nombre = " "
        assert_not @pelicula.valid?
    end

    test "la pelicula debe tener fecha de estreno" do
        @pelicula.fecha_estreno = " "
        assert_not @pelicula.valid?
    end

    test "la película debe tener sinopsis" do
        @pelicula.sinopsis = " "
        assert_not @pelicula.valid?
    end

    test "la sinopsis debe tener al menos 5 caracteres" do
        @pelicula.sinopsis = "a"*3
        assert_not @pelicula.valid?
    end

    test "la película debe tener tipo" do
        @pelicula.tipo = " "
        assert_not @pelicula.valid?
    end

    test "el tipo debe ser serie o pelicula" do
        @pelicula.tipo = "tipo_no_valido"
        assert_not @pelicula.valid?
    end
end