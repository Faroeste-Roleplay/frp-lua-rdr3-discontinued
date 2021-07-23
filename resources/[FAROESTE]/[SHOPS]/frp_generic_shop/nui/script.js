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

    if (event.data.type == "show") {
        $("body").fadeIn();
        $(".container").show();

        $(".slot-container").empty();
        // $("#description").empty();

        const activeTransations = event.data.activeTransations;

        let shopIndex;

        for (const [si, s_d] of Object.entries(event.data.shop_data)) {
            break;
        }

        let rendered = 0;

        for (let [transactionIndex, t_d] of Object.entries(event.data.shop_data.transactions)) {

            // transactionIndex = parseInt(transactionIndex) + 1;

            const item = t_d.item;

            let isActive = false;

            if (activeTransations[transactionIndex]) {
                isActive = true;
            }

            $('.slot-container').append(`
                <div class="slot ${isActive == false ? "deactivated" : ""}" data-transactionindex="${parseInt(transactionIndex) + 1}" onclick="select(this)">
                    <img src="nui://frp_inventory/nui/images/items/${item}.png">
                </div>
            `);

            rendered++;
        }

        if ((rendered % 4) != 0 || rendered < 16) {

            var needed = 0;

            for (i = 0; i < 4; i++) {
                if (((rendered + i) % 4) == 0) {
                    needed = i;
                    break;
                }
            }

            if ((rendered + needed) < 16) {
                needed = 16 - rendered;
            }

            for (i = 0; i < needed; i++) {
                $('.slot-container').append(`
                <div class="slot">
                </div>
            `);
            }
        }
    }

    if (event.data.type == "description") {

        $("#p_dollar").hide();
        $("#p_gold").hide();

        const data = event.data.data;

        const name = data.name;
        const description = data.description;
        const weight = data.weight;
        let transaction_dollar = data.transaction_dollar;
        const transaction_gold = data.transaction_gold;

        $(".description-title").text(name);
        $(".description-description").text(description);

        if (weight != undefined) {
            $("#weight").text(`${weight}KG`);
        }

        if (transaction_dollar != undefined) {

            if (!(isNaN(transaction_dollar))) {
                transaction_dollar = `$${transaction_dollar.toFixed(2)}`;
            }

            $("#p_dollar").text(`${transaction_dollar}`);
            $("#p_dollar").show();
        }

        if (transaction_gold != undefined) {
            $("#p_gold").text(`G${transaction_gold.toFixed(2)}`);
            $("#p_gold").show();
        }
    }
});

function select(element) {
    $('.selected').removeClass('selected');
    $(element).addClass('selected');

    const transactionIndex = $(element).data("transactionindex");

    $.post('http://frp_generic_shop/select', JSON.stringify({ transactionIndex: transactionIndex }));
}

function closeNUI() {
    $("body").hide();
    $.post("http://frp_generic_shop/hideNUI", JSON.stringify({}));
}

$(document).keyup(function(e) {
    if (e.key === "Escape") {
        closeNUI();
    }
});