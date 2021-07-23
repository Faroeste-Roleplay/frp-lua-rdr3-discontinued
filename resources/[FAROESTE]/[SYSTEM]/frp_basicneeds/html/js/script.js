let ativo = false;
let ativo2 = true;

function mounthud() {
    ativo2 = false
    if (ativo == false) {
        $('#hudsocial').fadeOut(500);
        setTimeout(() => {
            $('#hudsocial').fadeIn(500)
            $('#hudsocial').css('display', 'flex');    
            $('.hud1').css('margin-left', '1.0em');     
            $('#boxhud').css('bottom', '0.8em');
        }, 1000);
        ativo = true
    }
}

function NOmounthud() {
    ativo = false;
    if (ativo2 == false) {
        $('#hudsocial').fadeOut(500);
        setTimeout(() => {
            $('#hudsocial').fadeIn(500);
            $('#hudsocial').css('display', 'block');
            $('.hud1').css('margin-left', '2.0em');     
            $('#boxhud').css('bottom', '4.0em');
            $('#boxhud').css('left', '-1.8em');
        }, 1000);
        ativo2 = true
    }
}

function addpulse() {
    $('#progcircle1').addClass('pulse');
}



window.addEventListener('message', function (event) {
    
    if (event.data.action == "changeHealth") {
        bar1.animate(event.data.health / 250.0);
        if ((event.data.health / 250.0) <= 0.20) {
            $('#progcircle1').addClass('pulse');
        } else {
            $('#progcircle1').removeClass('pulse');
        }
    } else if (event.data.action == "updateNeeds") {
        let max = 1.0
        let hungerValue = event.data.hunger / 100;

        let thirstValue = event.data.thirst / 100;        
        
        bar2.animate(max - hungerValue);
        if ((max - hungerValue) <= 0.20) {
            $('#progcircle2').addClass('pulse');
        } else {
            $('#progcircle2').removeClass('pulse');
        }        
        
        bar3.animate(max - thirstValue);

        if ((max - thirstValue) <= 0.20) {
            $('#progcircle3').addClass('pulse');
        } else {
            $('#progcircle3').removeClass('pulse');
        }

    } else if (event.data.action == "isMounted") {
        mounthud();
    } else if (event.data.action == "notMounted") {
        NOmounthud();
    } else if (event.data.action == "showHud") {
        $('#container').fadeIn(500);
        setTimeout(() => { $('#container').css('display', 'flex'); }, 100);        
    } else if (event.data.action == "hideHud") {
        $('#container').fadeOut(500);
       // setTimeout(() => { $('#container').css('display', 'none'); }, 500);        
    }

    switch (event.data.action) {
        case 'updateStatusHud':
            $(".time").removeClass("timelower");            
            $(".time").empty();
            $(".time").append(event.data.time);
            $(".hudcomp").empty();
            $(".hudcomp").append(event.data.temp);
            $(".location").empty();
            $(".location").append(event.data.location);
            $(".compass").empty();
            $(".compass").append(event.data.compas);
            $("#boxSetHealth").css("width", event.data.health + "%");
            /*$("#boxSetHunger").css("width", event.data.hunger + "%");*/
            $("#boxSetStamina").css("width", event.data.stamina + "%");
            /*$("#boxSetThirst").css("width", event.data.thirst + "%");*/
            break;      
        case 'UpdateVoice':
            VoiceProx(event.data);
            break;
        case 'UpdateTalking':
            SetTalkingState(event.data);
    }
});
var bar1 = new ProgressBar.Circle(progcircle1, {
    strokeWidth: 11,
    trailColor: 'rgba(0,0,0,0.2)',
    trailWidth: 11,
    easing: 'easeInOut',
    duration: 500,
    color: 'rgba(245, 19, 0,1)',
    svgStyle: null
});

var bar2 = new ProgressBar.Circle(progcircle2, {
    strokeWidth: 11,
    trailColor: 'rgba(0,0,0,0.2)',
    trailWidth: 11,
    easing: 'easeInOut',
    duration: 500,
    color: 'rgba(255,255,255,0.8)',
    svgStyle: null
});

var bar3 = new ProgressBar.Circle(progcircle3, {
    strokeWidth: 11,
    trailColor: 'rgba(0,0,0,0.2)',
    trailWidth: 11,
    easing: 'easeInOut',
    duration: 500,
    color: 'rgba(255,255,255,0.8)',
    svgStyle: null
});

// var bar4 = new ProgressBar.Circle(progcircle4, {
//     strokeWidth: 11,
//     trailColor: 'rgba(0,0,0,0.2)',
//     trailWidth: 11,
//     easing: 'easeInOut',
//     duration: 500,
//     color: 'rgba(125,255,125,0.8)',
//     svgStyle: null
// });


VoiceProx = function(data) {
    if (data.prox == 1) {
        $("[data-voicetype='1']").fadeIn(150);
        $("[data-voicetype='2']").fadeOut(150);
        $("[data-voicetype='3']").fadeOut(150);
    } else if (data.prox == 2) {
        $("[data-voicetype='1']").fadeIn(150);
        $("[data-voicetype='2']").fadeIn(150);
        $("[data-voicetype='3']").fadeOut(150);
    } else if (data.prox == 3) {
        $("[data-voicetype='1']").fadeIn(150);
        $("[data-voicetype='2']").fadeIn(150);
        $("[data-voicetype='3']").fadeIn(150);
    }
    CurrentProx = data.prox;
}

SetTalkingState = function(data) {
    if (data.isTalking) {
        $('.voice-block').addClass('active');
    } else {
        $('.voice-block').removeClass('active');
    }
}

function widthHeightSplit(value, ele) {
    let height = 25.5;
    let eleHeight = (value / 100) * height;
    let leftOverHeight = height - eleHeight;

    ele.css("height", eleHeight + "px");
    ele.css("top", leftOverHeight + "px");
};

