window.addEventListener("message", function (event) { //lua actions
    if (event.data.action == 'open') {
        $(".inner-container").html("<h2>MENU BANDO</h2>");
        $('.container').fadeIn();
        $('h2').text('Menu Bando - ' + event.data.clanName);
        $.each(event.data.data, function (charId, data) {
            if (data != null) {
                if (data.isOnline) { status = "<on>Online</on>" } else { status = "<off>Offline</off>" }
                $('.inner-container').append(`
                <div class="slot" id="${charId}">
                    <div class="img-container">
                        <img src="https://filmcrz.github.io/blips/index.files/image058.png" />
                    </div>
                    <div class="text-container">
                        <span>${data.name} ${status}</span>
                        <span>${rankToRankName(data.rank)}</span>
                    </div>
                    <div class="um-container">
                        <div id="Remove-${charId}" onclick="kick(${data.UserID})">
                            <img src="https://filmcrz.github.io/blips/index.files/image709.png">
                        </div>
                        <div id="Info-${charId}" >
                            <img src="https://filmcrz.github.io/blips/index.files/image747.png">
                        </div>
                    </div>
                    <div class="pd-container">
                        <div id="Promote-${charId}" onclick="promote(${data.UserID})">
                            <img src="https://filmcrz.github.io/blips/index.files/image691.png">
                        </div>
                        <div id="Unpromote-${charId}" onclick="demote(${data.UserID})">
                            <img src="https://filmcrz.github.io/blips/index.files/image699.png">
                        </div>
                    </div>
                </div>
            `);
                Tooltip(document.getElementById(`Promote-${charId}`), "Subir Cargo")
                Tooltip(document.getElementById(`Unpromote-${charId}`), "Descer Cargo")
                Tooltip(document.getElementById(`Remove-${charId}`), "Remover do Bando")
                Tooltip(document.getElementById(`Info-${charId}`), `
                <a style="color: white;"text-align:center;"> Dados do jogador no bando:</a><br>
                <a style="color: white;">Passaporte: <font style="color: rgba(127,220,86,1.0);"> ${data.UserID} </font></a><br>
                <a style="color: white;">Level: <font style="color: rgba(127,220,86,1.0);"> ${data.level}</font></a><br>
                <a style="color: white;">Titulacao: <font style="color: rgba(127,220,86,1.0);"> ${rankToRankName(data.rank)}</font></a><br>
            `)
            }
        });
    }
    if (event.data.action == 'close') {
        $('.container').hide();
        $('.inner_container').html('');
    }
});

function promote(element) {
    var charId = $(element).attr('id');
    $.post('http://frp_posse/promote', JSON.stringify({
        charId: element,
    }));
}

function demote(element) {
    var charId = $(element).attr('id');
    $.post('http://frp_posse/demote', JSON.stringify({
        charId: element,
    }));
}

function kick(element) {
    var charId = $(element).attr('id');
    $.post('http://frp_posse/kick', JSON.stringify({
        charId: element,
    }));
}

function leave(element) {
    var charId = $(element).attr('id');
    $.post('http://frp_posse/leave', JSON.stringify({
        charId: element,
    }));
}

function rankToRankName(rank) {
    switch (rank) {
        case 1:
            return 'Dono';
            break;
        case 2:
            return 'Líder';
            break;
        case 3:
            return 'Membro';
            break;
        default:
            return 'Membro';
    }
}

$(document).ready(function () {
    $(document).keyup(function (e) {
        if (e.which == 27) {
            $('.container').hide();
            $('.inner_container').html('');
            $.post('http://frp_posse/NUICallbackOff', JSON.stringify({}));
        }
    });
})

function Tooltip(el, text) {
    el.onmouseover = function () {
        if (!el.querySelector(".tooltip")) {
            el.innerHTML += '<div class="tooltip">' + text + '</div>'
        }
    }
    el.onmouseout = function () {
        el.removeChild(el.querySelector(".tooltip"))
    }
}