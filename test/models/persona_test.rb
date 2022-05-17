require 'test_helper'

class PersonaTest < ActiveSupport::TestCase
    def setup 
        @persona = Persona.create(nombre: "Steven Spielberg", departamento: "Dirección")
    end

    test "persona debería ser valido" do
        assert @persona.valid?
    end

    test "Persona debería tener un nombre" do
        @persona.nombre = " "
        assert_not @persona.valid?
    end

    test "persona debería tener un departamento" do
        @persona.departamento = " "
        assert_not @persona.valid?
    end
end