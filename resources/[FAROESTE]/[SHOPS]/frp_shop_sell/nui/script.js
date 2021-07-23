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

    var renderedItems = 0;

    for (const [shopSubType, shopItemList] of Object.entries(shops[shopId])) {

        if (shopSubType != "name") {

            for (const [i, itemData] of Object.entries(shopItemList)) {


                var itemId = itemData[0];
                var itemPrice_dollar = itemData[1];
                // var itemPrice_gold = itemData[2];
                var itemAmountNeededToSell = itemData[3];
                var itemName = itemData[4];
                var itemDescription = itemData[5];
                // var itemWeight = itemData[6];
                var itemWeight = 0;

                itemWeight = itemWeight.toFixed(1);
                itemPrice_dollar = (itemPrice_dollar / 100).toFixed(2);
                // itemPrice_gold = (itemPrice_gold / 100).toFixed(2);

                $('.slot-container').append(`
                    <div class="slot" id="${itemId}" onclick="select(this)">
                        <img src="nui://frp_inventory/nui/images/items/${itemId}.png">
                    </div>
                `);

                var element = $(`.slot-container #${itemId}`);
                $(element).attr('shopId', shopId);
                $(element).attr('minSell', itemAmountNeededToSell);
                $(element).attr('name', itemName);
                $(element).attr('descripition', itemDescription);
                $(element).attr('weight', itemWeight);
                $(element).attr('p_dollar', itemPrice_dollar);
                // $(element).attr('p_gold', itemPrice_gold);

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

function sell(gold) {
    if ($('.selected').length > 0) {
        var itemName = $('.selected').attr('name');
        $('#confirmation-container').fadeIn(250);
        $('#confirmation-container #confirm_title').text(itemName);
        buyingWithGold = gold;

        // $('#p_gold_img').removeClass('fhover_gold');
        $('#p_dollar_img').removeClass('fhover_dollar');

        // if (buyingWithGold) {
        //     $('#p_gold_img').addClass('fhover_gold');
        // } else {
            $('#p_dollar_img').addClass('fhover_dollar');
        // }
    }
}

function cancel() {
    $('#confirmation-container').hide();
    // $('#p_gold_img').removeClass('fhover_gold');
    // $('#p_dollar_img').removeClass('fhover_dollar');
    buyingWithGold = false;
}

function sellItem() {
    if ($('.selected').length > 0) {
        var shopId = $('.selected').attr('shopId');
        var itemId = $('.selected').attr('id');

        $('#confirmation-container').hide();
        // $('#p_gold_img').removeClass('fhover_gold');
        // $('#p_dollar_img').removeClass('fhover_dollar');

        $.post('http://frp_shop_sell/sellItem', JSON.stringify({ shopId: shopId, itemId: itemId, withGold: buyingWithGold }));
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

        let item_name = $(element).attr('name');
        let item_min_sell = $(element).attr('minSell');
        let item_description = $(element).attr('description');
        let item_weight = $(element).attr('weight');
        let item_p_dollar = $(element).attr('p_dollar');
        // var item_p_gold = $(element).attr('p_gold');

        // $('#name').text('x' + item_min_sell + ' ' + item_name);
        $('#name').text(item_name);
        $('#description').text(item_description);
        // $('#weight').text(item_weight + 'KG');
        // if (item_p_gold != undefined) {
        //     $('#p_dollar').show();
        //     $('#p_dollar').text(item_p_dollar);
        // }else{
        //     $('#p_dollar').hide();
        // }
        $('#p_dollar').text("$" + item_p_dollar);

        let itemId = $(element).attr('id');
        let shopId = $(element).attr('shopId');

        $.post('http://frp_shop_sell/selectedItem', JSON.stringify({ shopId: shopId, itemId: itemId}));

        // $.post("http://frp_shop_sell/selectedItem", JSON.stringify({
        //     itemId: itemId,
        //     shopId: shopId
        // }));
        // $('#confirmation-container #confirm_title').text(item_name);
    }
}

function unSelect(element) {
    if ($(element).hasClass('selected')) {
        $(element).removeClass('selected');
        $('#name').text('');
        $('#description').text('');
        $('#confirmation-container').hide();
        // buyingWithGold = false;
        // $('#p_gold_img').removeClass('fhover_gold');
        // $('#p_dollar_img').removeClass('fhover_dollar');

        $.post("http://frp_shop_sell/unselectedItem", JSON.stringify({}));
    }
}

function close() {
    $(".container").hide();
    $.post("http://frp_shop_sell/NUIFocusOff", JSON.stringify({}));
}

$(document).keyup(function(e) {
    if (e.key === "Escape") {
        $(".container").fadeOut(100);
        $.post('http://frp_shop_sell/focusOff');
    }
});