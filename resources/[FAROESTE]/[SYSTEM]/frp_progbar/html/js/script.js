var cancelledTimer = null;

$('document').ready(function() {
    VPProgBar = {};



    VPProgBar.Progress = function(data) {
        clearTimeout(cancelledTimer);

        $("#progress-label").text(data.label);

        $(".progress-container").fadeIn('fast', function() {
            $(".progress-container").css("opacity", 1);
            $("#progress-barbg").stop().css({"width": "20vh"}).animate({
              width: 0
            }, {
              duration: parseInt(data.duration),
              complete: function() {
                $(".progress-container").fadeOut('fast', function() {
                    $('#progress-barbg').removeClass('cancellable');
                    $("#progress-barbg").css("width", 0);
                    $(".progress-container").css("opacity", 0);
                    $.post('http://frp_progbar/actionFinish', JSON.stringify({
                        })
                    );
                })
              }
            });
        });
    };

    VPProgBar.ProgressCancel = function() {
        $("#progress-barbg").text("CANCELADO");
        $("#progress-barbg").stop().css( {"width": 0});
        $('#progress-barbg').removeClass('cancellable');

        cancelledTimer = setTimeout(function () {
            $(".progress-container").fadeOut('fast', function() {
                $("#progress-barbg").css("width", "20vh");
                $.post('http://frp_progbar/actionCancel', JSON.stringify({
                    })
                );
            });
        }, 1000);
    };

    VPProgBar.CloseUI = function() {
        $('.main-container').fadeOut('fast');
    };
    
    window.addEventListener('message', function(event) {
        switch(event.data.action) {
            case 'frp_progbar':
                VPProgBar.Progress(event.data);
                break;
            case 'frp_progbar_cancel':
                VPProgBar.ProgressCancel();
                break;
        }
    });
});