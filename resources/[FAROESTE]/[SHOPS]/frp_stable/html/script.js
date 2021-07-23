$('#creatormenu').fadeOut(0);


window.addEventListener('message', function(event) {
    if (event.data.action == "show") {
        $("#creatormenu").fadeIn(500);
       

        if (event.data.shopData) {
            for (const [index, table] of Object.entries(event.data.shopData)) {
                var horseCategory = table.name

                if ($(`#page_shop .scroll-container .collapsible #${index}`).length <= 0) {
                    $('#page_shop .scroll-container .collapsible').append(`
                         <li id="${index}">
                            <div class="collapsible-header col s12 panel ">
                                <div class="col s12 panel-title">
                                    <h6 class="grey-text">${horseCategory}</h6>
                                </div>
                            </div>
                            <div class="collapsible-body item-bg">
                            </div>
                        </li>
                    `);
                }

                for (const [_, horseData] of Object.entries(table)) {
                    if (_ != 'name') {
                        let Modelhorse
                        var HorseName = horseData[0];
                        var priceGold = horseData[1];
                        var priceDolar = horseData[2];
                        var BuyModel = null;

                        // priceGold = '';
                        // priceDolar = '';
                     

                        $(`#page_shop .scroll-container .collapsible #${index} .collapsible-body`).append(`

                            <div id="${_}" onhover="loadHorse(this)" class="col s12 panel item">

                                <div class="col s6 panel-col item">
                                    <h6 class="grey-text title" style="color:white;">${HorseName}</h6>
                                </div>          

                                <div class="buy-buttons">                                       
                                    <button class="btn-small"  onclick="buyHorse('${_}', ${priceGold}, true)">                                                
                                        <img src="img/gold.png"><span class="horse-price">${priceGold}</span>
                                    </button>                                          
                                    <button class="btn-small"  onclick="buyHorse('${_}', ${priceDolar}, false)">
                                        <img src="img/money.png"><span class="horse-price">${priceDolar}</span>
                                    </button>
                                </div>
                                
                            </div>
                        `);

                        $(`#page_shop .scroll-container .collapsible #${index} .collapsible-body #${_}`).hover(function() {                       
                            $( this ).click(function() {                        
                             

                                $(Modelhorse).addClass("selected");
                                $('.selected').removeClass("selected"); 

                                Modelhorse = $(this).attr('id');                       
                                $(this).addClass('selected');

                                $.post('http://frp_stable/loadHorse', JSON.stringify({ horseModel: $(this).attr('id') }));
                            });                       
                            
                        }, function() {});


                    }
                }

            }

            
            $('#page_myhorses .scroll-container .collapsible').html('');
            $('#page_myhorses .scroll-container .collapsible').append(`
                <li>
                    <div class="collapsible-header col s12 panel ">
                        <div class="col s12 panel-title">
                            <h6 class="grey-text">VOCÊ NÃO POSSUI CAVALOS</h6>
                        </div>
                    </div>
                </li>
            `);
            $('.collapsible').collapsible();
        }

        if (event.data.action == "hide") {
            $("#creatormenu").fadeOut(500);
        }
    }

    
    if (event.data.EnableCustom == "true") {
        $('#button-customization').removeClass("disabled");
    } else {
        $('#button-customization').addClass("disabled");
    }
    

    if (event.data.myHorsesData) {

        $('#page_myhorses .scroll-container .collapsible').html('');

        for (const [ind, tab] of Object.entries(event.data.myHorsesData)) {
        
            let HorseName = tab.name;
            let HorseID = tab.id;
            let HorseIdModel = tab.model;
            let componentsh = tab.components;
            let selectedh = tab.selected;         

            $('#page_myhorses .scroll-container .collapsible').append(`
                <li>
                    <div id="heads" class="collapsible-header col s12 panel" style="background-color: transparent; border: 0;">
                        <div class="col s12 panel-title">
                            <h6 class="grey-text">${HorseName}</h6>
                        </div>
                    </div>
                    <div class="collapsible-body col s12 panel item" id="${HorseID}">
                        <div class="col s6 panel-col item" onclick="SelectHorse(${HorseID})">
                            <h6 class="grey-text title">Escolher</h6>
                        </div>
                        <div class="col s6 panel-col item" onclick="SellHorse(${HorseID})">
                            <h6 class="grey-text title">Vender por $10</h6>
                        </div>
                    </div>
                </li> 
            `);
            
            $(`#page_myhorses .scroll-container .collapsible #${HorseID}`).hover(function() {  
                $( this ).click(function() {                    
                    console.log('clicou') 
                    let HorseSEID
                    $(HorseID).addClass("selected");
                    $('.selected').removeClass("selected"); 

                    HorseSEID = $(HorseID).attr('id');             
                    $(HorseID).addClass('selected');

                    $.post('http://frp_stable/loadMyHorse', JSON.stringify({ IdHorse: HorseID, horseModel: HorseIdModel, HorseComp: componentsh}));
                });                         
            }, function() {});
        }
    }

});

function confirm(){
    $.post('http://frp_stable/CloseStable')

    $('#button-customization').addClass("disabled");
    $('#page_myhorses .scroll-container .collapsible').html('');
    $('#page_shop .scroll-container .collapsible').html('');
    $("#creatormenu").fadeOut(500);
}

var currentPage = 'page_myhorses';

$('.menu-selectb').on('click', function() {
    $(`#${currentPage}`).hide();

    currentPage = $(this).data('target');
    $(`#${currentPage}`).show();

    $('.menu-selectb.active').removeClass('active');
    $(this).addClass('active');
});

$(".button-right").on('click', function() {
    var inputElement = $(this).parent().find('input');
    var component = $(inputElement).attr('id');

    var value = Number($(inputElement).attr('value'));
    // value = Number(String.split(value, '/')[0]);
    var nValue = value + 1;

    var min = $(inputElement).attr('min');
    var max = $(inputElement).attr('max');

    if (nValue > max) {
        nValue = min;
    }

    $(inputElement).attr('value', nValue);

    var titleElement = $(this).parent().parent().find('.grey-text');
    var text = titleElement.text();
  //  var component = text.split(' ')[0];
    titleElement.text(component + ' ' + nValue + '/' + max);
    $.post('http://frp_stable/'+component, JSON.stringify({ id: nValue }));
});

$(".button-left").on('click', function() {
    var inputElement = $(this).parent().find('input');
    var component = $(inputElement).attr('id');

    var value = Number($(inputElement).attr('value'));
    // value = Number(String.split(value, '/')[0]);

    var nValue = value - 1;

    var min = $(inputElement).attr('min');
    var max = $(inputElement).attr('max');

    if (nValue < min) {
        nValue = max;
    }

    $(inputElement).attr('value', nValue);

    var titleElement = $(this).parent().parent().find('.grey-text');
    var text = titleElement.text();
  //  var component = text.split(' ')[0];
    titleElement.text(component + ' ' + nValue + '/' + max);
    $.post('http://frp_stable/'+component, JSON.stringify({ id: nValue }));
});

$(".input-number").on("change paste keyup", function() {

    var min = Number($(this).attr('min'));
    var max = Number($(this).attr('max'));

    var value = $(this).val();

    if (value == '' || value < min) {
        value = min;
        $(this).val(value);
    }

    if (value > max) {
        value = max;
        $(this).val(value);
    }

    var titleElement = $(this).parent().parent().find('.grey-text');
    var text = titleElement.text();    
    var component = text.split(' ')[0];
    
    titleElement.text(component + ' ' + value + '/' + max);

});

function buyHorse(Modelhor, price, isGold) {    
    if (isGold) {        
        $.post('http://frp_stable/BuyHorse', JSON.stringify({ ModelH: Modelhor, Gold: price, IsGold: isGold }));
    } else {
        $.post('http://frp_stable/BuyHorse', JSON.stringify({ ModelH: Modelhor, Dollar: price, IsGold: isGold }));    
    }    
}


function SelectHorse(IdHorse) {    
    $.post('http://frp_stable/selectHorse', JSON.stringify({ horseID: IdHorse }))    
}


function SellHorse(IdHorse) {    
    $.post('http://frp_stable/sellHorse', JSON.stringify({ horseID: IdHorse }))    
}
