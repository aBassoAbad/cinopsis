require 'test_helper'

class UsuarioTest < ActiveSupport::TestCase
    def setup
        @usuario = Usuario.new(nombre: "alejandro", email: "alejandro@correo.com")
    end

    test "usuario valido" do
        assert @usuario.valid?
    end

    test "el usuario debe tener nombre" do
        @usuario.nombre = " "
        assert_not @usuario.valid?
    end

    test "el usuario debe tener email" do
        @usuario.email = " "
        assert_not @usuario.valid?
    end

    test "el nombre debe tener menos de 50 caracteres" do
        @usuario.nombre = "a"*51
        assert_not @usuario.valid?
    end

    test "el email no debe ser demasiado largo" do
        @usuario.email = "a"*250 + "@outlook.com"
        assert_not @usuario.valid?
    end

    test "el email debe tener el formato adecuado" do
        email_validos = %w[usuario@correo.com ALEJANDRO@gmail.com M.ejemplo@yahoo.ca john+smith@co.uk.org]
        email_validos.each do |email|
            @usuario.email = email
            assert @usuario.valid?
        end
    end

    test "debería rechazar email no válidos" do
        email_no_validos =  %w[alejandro@correo alejandro@correo,com alejandro.nombre@gmail. joe@bar+foo.com]
        email_no_validos.each do |email|
            @usuario.email = email
            assert_not @usuario.valid?
        end
    end

    test "el email debe ser único y case insensitive" do
        usuario_duplicado = @usuario.dup
        usuario_duplicado.email = @usuario.email.upcase
        @usuario.save
        assert_not usuario_duplicado.valid?
    end

    test "el email debe ser minuscula antes de introducirse en la bd" do
        email_mayus = "AlejANdRo@CorrEO.com"
        @usuario.email = email_mayus
        @usuario.save
        assert_equal email_mayus.downcase, @usuario.reload.email
    end
end