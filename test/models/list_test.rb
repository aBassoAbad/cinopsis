require 'test_helper'

class ListTest < ActiveSupport::TestCase
    def setup
        @usuario = Usuario.create(nombre: "usuario", email: "usuario@correo.com", password: "contrasena")
        @lista = List.new(nombre_lista: "lista", usuario_id: @usuario.id)
    end

    test "La lista debería ser válida" do
        assert @lista.valid?
    end

    test "La lista debe tener nombre" do
        @lista.nombre_lista = " "
        assert_not @lista.valid?
    end

    test "La lista debe pertenecer a un usuario" do
        @lista.usuario_id = ""
        assert_not @lista.valid?
    end

    test "Un usuario ni puede tener dos listas con el mismo nombre" do
        lista_nueva = @lista.dup
        @lista.save
        assert_not lista_nueva.valid?
    end
end