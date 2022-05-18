$(document).ready(function(){
    $('#cerrar-mensaje').on("click", function() {
        $('#mensajes').slideUp(500);
    })
    
    //$('#mensajes').hide().delay(5000).fadeOut(400);
    $("#mensajes").fadeTo(10000, 500).slideUp(500, function() {
        $("#mensajes").slideUp(500);
      });
});
