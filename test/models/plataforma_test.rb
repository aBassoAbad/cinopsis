require 'test_helper'

class PlataformaTest < ActiveSupport::TestCase
    def setup
        @plataforma = Plataforma.create(nombre: "Netflix")
    end

    test "plataforma debería ser válida" do
        assert @plataforma.valid?
    end

    test "plataforma debería tener nombre" do
        @plataforma.nombre = " "
        assert_not @plataforma.valid?
    end

    test "el nombre no debe tener más de 50 caracteres" do
        @plataforma.nombre = "a"*51
        assert_not @plataforma.valid?
    end
end