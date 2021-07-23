document.addEventListener('DOMContentLoaded', function() {
    $(".container").hide();
    $("#confirmation-container").hide();
});


let shops = {};

window.addEventListener("message", function(event) {
    var data = event.data;

    if (data.clear == true) {
        $(".slot-container").empty();
    }

    if (data.display == true) {

        if (data.firstTimeData) {

            data.firstTimeData.forEach(function(shopData, index) {
                for (const [shopSubType, shopItemList] of Object.entries(shopData)) {
                    if (shopSubType == "name") {
                        shops[shopItemList] = shopData;
                        break
                    }
                }
            });
        }

        $(".container").show();
        draw(data.shopId);
    }

    if (data.display == false) {
        $(".container").fadeOut(100);
    }
});

function draw(shopId) {

    $('.slot-container').html('');

    $('.title').text(shopId);

    var renderedItems = 0;

    for (const [shopSubType, shopItemList] of Object.entries(shops[shopId])) {

        if (shopSubType != "name") {

            for (const [i, itemData] of Object.entries(shopItemList)) {

                var itemId = itemData[0];
                var itemLevel = itemData[1];
                var itemPrice_dollar = itemData[2];
                var itemPrice_gold = itemData[3];
                var itemName = itemData[4];
                var itemWeight = itemData[5];
                var itemDescription = itemData[6];

                itemWeight = itemWeight.toFixed(1);
                itemPrice_dollar = (itemPrice_dollar / 100).toFixed(2);
                itemPrice_gold = (itemPrice_gold / 100).toFixed(2);

                $('.slot-container').append(`
                    <div class="slot" id="${itemId}" onclick="select(this)">
                        <img src="nui://frp_inventory/nui/images/items/${itemId}.png">
                    </div>
                `);

                var element = $(`.slot-container #${itemId}`);
                $(element).attr('shopId', shopId);
                $(element).attr('name', itemName);
                $(element).attr('description', itemDescription);
                $(element).attr('weight', itemWeight);
                $(element).attr('p_dollar', itemPrice_dollar);
                $(element).attr('p_gold', itemPrice_gold);

                renderedItems++;
            }
            break;
        }
    }

    if ((renderedItems % 4) != 0 || renderedItems < 16) {

        var needed = 0;

        for (i = 0; i < 4; i++) {
            if (((renderedItems + i) % 4) == 0) {
                needed = i;
                break;
            }
        }

        if ((renderedItems + needed) < 16) {
            needed = 16 - renderedItems;
        }

        for (i = 0; i < needed; i++) {
            $('.slot-container').append(`
            <div class="slot">
            </div>
        `);
        }
    }
}

let buyingWithGold = false;

function buy(gold) {
    if ($('.selected').length > 0) {
        var itemName = $('.selected').attr('name');
        $('#confirmation-container').fadeIn(250);
        $('#confirmation-container #confirm_title').text('Comprar ' + itemName);
        buyingWithGold = gold;

        $('#p_gold_img').removeClass('fhover_gold');
        $('#p_dollar_img').removeClass('fhover_dollar');

        if (buyingWithGold) {
            $('#p_gold_img').addClass('fhover_gold');
        } else {
            $('#p_dollar_img').addClass('fhover_dollar');
        }
    }
}

function cancelPurchase() {
    $('#confirmation-container').hide();
    $('#p_gold_img').removeClass('fhover_gold');
    $('#p_dollar_img').removeClass('fhover_dollar');
    buyingWithGold = false;
}

function buyItem() {
    if ($('.selected').length > 0) {
        var shopId = $('.selected').attr('shopId');
        var itemId = $('.selected').attr('id');

        $('#confirmation-container').hide();
        $('#p_gold_img').removeClass('fhover_gold');
        $('#p_dollar_img').removeClass('fhover_dollar');

        $.post('http://frp_shop_buy/buyItem', JSON.stringify({ shopId: shopId, itemId: itemId, withGold: buyingWithGold }));
        buyingWithGold = false;

    }
}
//     $("body").click(function(e) {
//         if (e.target.id == "confirmation-container" || $(e.target).parents("#confirmation-container").length) {} else {
//             if ($('#confirmation-container').is(':visible')) {
//                 $('#confirmation-container').fadeOut(100);
//             }
//         }
//     });
// })


// $(function() {
function select(element) {
    if ($(element).attr('id') != undefined) {
        $('.selected').removeClass('selected');
        $('#name').text('');
        $('#description').text('');

        $(element).addClass('selected');

        var item_name = $(element).attr('name');
        var item_description = $(element).attr('description');
        var item_weight = $(element).attr('weight');
        var item_p_dollar = $(element).attr('p_dollar');
        var item_p_gold = $(element).attr('p_gold');

        $('#weight').text(item_weight + 'KG');
        $('#p_dollar').text(item_p_dollar);
        $('#p_gold').text(item_p_gold);

        $('.description-title').text(item_name);
        $('.description-description').text(item_description);
        $('#confirmation-container #confirm_title').text(item_name);
    }
}

function unSelect(element) {
    if ($(element).hasClass('selected')) {
        $(element).removeClass('selected');
        buyingWithGold = false;
        $('#name').text('');
        $('.description-title').text('');
        $('.description-description').text('');
        $('#confirmation-container').hide();
        $('#p_gold_img').removeClass('fhover_gold');
        $('#p_dollar_img').removeClass('fhover_dollar');
    }
}

function close() {
    $(".container").hide();
    $.post("http://frp_shop_buy/NUIFocusOff", JSON.stringify({}));
}

$(document).keyup(function(e) {
    if (e.key === "Escape") {
        $(".container").fadeOut(100);
        $.post('http://frp_shop_buy/focusOff');
    }
});