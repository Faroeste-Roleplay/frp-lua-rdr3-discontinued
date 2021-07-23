$(".container").fadeOut(500);

window.addEventListener('message', function(event) {
    if (event.data.action == "show") { 
        $(".container").fadeIn(500);

        let Dados = event.data.infos;

        let id = Dados.charid;

        let idLength = id.toString().length;

        let maxLength = 8;

        let digitToAdds = maxLength - idLength;

        let formatedId = "";

        for (i = 0; i < digitToAdds; i ++){
            formatedId = formatedId + "0"                   
        }

        formatedId = formatedId + id.toString();

        formatedId = formatedId.substring(0, 3) + '-' + formatedId.substring(3);

        formatedId = formatedId.substring(0, 6) + '-' + formatedId.substring(6);

        $('.body-document').html('');

        $('.body-document').append(`
            <div class="content-header">
                <span id="charid">${formatedId}</span>
            </div>
            <div class="content-center">
                <span id="name" class="name">${Dados.name}</span>
            </div>
            <div class="content-footer">
                <span id="age">${Dados.age}</span>
                <span id="name" class="signature">${Dados.name}</span>
            </div>
        `);

        setTimeout(function(){  
            $('.body-document').html('');
            $(".container").fadeOut(500);
        }, 15000);

    }

    if (event.data.action == "hide") { 
        $(".container").fadeOut(500);
        $('.body-document').html('');
    }
});