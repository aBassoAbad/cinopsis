require "test_helper"

class PaginasTest < ActionDispatch::IntegrationTest
  test "Accede a la página home" do
    get paginas_home_url
    assert_response :success
  end

  test "Accede a la ruta raiz" do
    get root_url
    assert_response :success
  end
end
