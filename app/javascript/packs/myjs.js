$(document).ready(function(){
    $('#cerrar-mensaje').on("click", function() {
        $('#mensajes').slideUp(500);
    })
    
    $("#mensajes").fadeTo(10000, 500).slideUp(500, function() {
        $("#mensajes").slideUp(500);
    });

    $("#buscar").on("click", function(event) {
        event.preventDefault();
        var texto = $("#buscar_text").val()
        window.location.replace("/buscar/"+texto);
    })
});
