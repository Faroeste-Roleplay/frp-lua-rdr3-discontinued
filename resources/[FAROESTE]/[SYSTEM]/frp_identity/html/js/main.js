window.addEventListener('message', (event) => {
    if (event.data.type == 1){
        LoadCharacters(event.data.list);
    } else if(event.data.type == 2) {
        window.location.reload();
    }
});

var Identity = {};
var LimitCharacters = 4


function LoadCharacters(list) {

    $(".loading").html('');
    
    $(".container").html(`    
        <div class="header-text">${LOCALES[LOCALE].CHARACTERS}</div>			

        <div class="description-text">${LOCALES[LOCALE].DESCRIPTION}</div>		

        <div class="main">


        </div>
        <div class="bottom-line"></div>

        <div class="buttons">

            <div class="enter-world" onclick="enterWorld()">
            ${LOCALES[LOCALE].ENTER_WORLD}
            </div>

        </div>
    `);


    let listLength = 0;

    if (list) {
        listLength = list.length;
    }

    for (let i = 0; i < listLength; i++){
        let char = list[i];

        $(".main").append(`
            <div class="char ${i}" onclick="charSelected(${char.charid}, ${i})">
                <div class="char_name">${char.characterName}</div>
            </div>
        `);     
    }

    let empty_slot = LimitCharacters - listLength;   

    if (empty_slot > 0) {
        for (let i = 0; i < empty_slot; i++){
            $(".main").append(`
            <div class="empty" onclick="createNewCharacter()">
                <span>${LOCALES[LOCALE].CREATE_CHAR}</span>
            </div>        
        `);     
        }
    }    
}

$(document).on('click', '.char', function(e){
    $(".selected").removeClass("selected");
    e.currentTarget.className += " selected";
});

function charSelected(charId, index) {			
    Identity.CharSelected = charId;
    $(".enter-world").css("opacity", "1")
    $.post('http://frp_identity/selectCharacter', JSON.stringify(index));
}

function enterWorld() {			
    if(Identity.CharSelected != null){

        $.post('http://frp_identity/spawnCharacterSelected', JSON.stringify(Identity.CharSelected));

        $(".container").fadeOut(500);        
        setTimeout(function(){ $(".container").html(''); }, 2000);
        
    }
}

function createNewCharacter() {

    $(".container").fadeOut(500);
    $(".container").html('');

    $.post('http://frp_identity/createCharacter', JSON.stringify({}));
}


function deleteChar() {
    if(Identity.CharSelected != null){
        $.post('http://frp_identity/deleteCharacter', JSON.stringify(Identity.CharSelected));
    }
}

