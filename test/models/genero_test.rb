require 'test_helper'

class GeneroTest < ActiveSupport::TestCase
    def setup
        @genero = Genero.new(nombre: "Ciencia Ficción")
    end

    test "El genero debería ser válido" do
        assert @genero.valid?
    end

    test "El genero debe tener nombre" do
        @genero.nombre = " "
        assert_not @genero.valid?
    end
end