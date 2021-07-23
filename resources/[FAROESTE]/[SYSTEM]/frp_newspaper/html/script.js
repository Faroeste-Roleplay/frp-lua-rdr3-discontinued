$("body").fadeOut(0);

window.addEventListener('message', function(event) {
    if (event.data.action == "show") {
        $("body").fadeIn(500);
    }

    if (event.data.action == "hide") {
        $("body").fadeOut(500);
    }
});


$(function () {

    document.onkeyup = function (data) {
        if (open) {
            // data.getModifierState("Shift") &&
            if (data.which == 27) {
                close()
                $.post('http://frp_newspaper/close');    
            }
        }
    };

});


$(function close() {
    $.post('http://frp_newspaper/close');    
    $("body").fadeOut(500);

});