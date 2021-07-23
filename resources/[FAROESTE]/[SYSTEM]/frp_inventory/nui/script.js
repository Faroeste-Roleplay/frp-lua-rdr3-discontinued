var primaryItemList = [];
var secondaryItemList = [];
var indexSelected = null;
var shortcutPressed = null;

var hotbarSlotSelected = 5;

var hasItemDropCooldown = false;

var lastRangeValue = 1.0;

//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
// Rever as classes [documentos, kits], talvez mudar para [armas, munições]
// verify condition

// Criar uma descrição para os items em _core/config/Items.lua

var mouseX, mouseY;
$(document).mousemove(function(e) {
    mouseX = e.pageX;
    mouseY = e.pageY;
}).mouseover();

document.addEventListener("DOMContentLoaded", function(event) {
    $('.hotbar').hide();

    $('.description-range').hide();

    // $("#primary-inventory").css('opacity', '1');
    // $("#primary #background-image").css('opacity', '0.98');

    // $("#secondary").show();
    // $("#secondary #background-image").css('opacity', '0.98');

    $('#range-input').on('input', function() {

        lastRangeValue = this.value;

        let perc = (this.value / this.max) * 100;

        $(this).css('background', `linear-gradient(to right, rgba(116, 116, 116, 0.534) ${perc}%, rgba(128, 128, 128, 0.2) ${perc}%)`);

        $("#range-output").text(this.value);
    });

});


window.addEventListener("message", function(event) {
    if (event.data.action == 'hide') {
        $("#primary-inventory").css('opacity', '0');
        $("#primary #background-image").css('opacity', '0');
        $("#secondary").hide();
    } else {

        if (event.data.type == 'clearPrimary') {
            primaryItemList = [];
            $("#primary-inventory").css('opacity', '1');
            $("#primary #background-image").css('opacity', '0.98');
        }

        if (event.data.type == 'clearSecondary') {
            secondaryItemList = [];
            $("#secondary").show();
            $("#secondary #background-image").css('opacity', '0.98');
        }

        if (event.data.type == 'showHotbar') {           
            $('.hotbar').fadeIn(500).delay(5000).fadeOut(500);
        }

        if (event.data.type == 'nextHotbarSlot' || event.data.type == 'previousHotbarSlot') {

            if (hotbarSlotSelected != undefined) {
                hotbarSlotSelected = hotbarSlotSelected + 1;
                if (hotbarSlotSelected == 6) {
                    hotbarSlotSelected = 1;
                }
            } else {
                hotbarSlotSelected = 1;
            }

            $('.hotbar').fadeIn(500).delay(5000).fadeOut(500);

            $('.hotbar-slot-selected').removeClass("hotbar-slot-selected");

            let element = $(`.hotbar .slot:nth-child(${hotbarSlotSelected}`);
            element.addClass("hotbar-slot-selected");

            let itemId = $(element).attr('itemId');

            $.post('http://frp_inventory/interactWithHotbarSlot', JSON.stringify({
                itemId: itemId,
            }));
        }

        if (event.data.primarySlots) {
         
            $.each(event.data.primarySlots, function(slotId, Slot) {
                
                if (Slot) {
                    if (Slot.amount[0] > 0 || Slot.amount > 0) {
                        primaryItemList[slotId] = Slot;
                    } else {
                        delete primaryItemList[slotId];
                    }
                }
            });


            if (event.data.primaryWeight != undefined) {
                var weight = event.data.primaryWeight.toFixed(1);
                var maxWeight = event.data.primaryMaxWeight
                if (maxWeight != undefined) {
                    $('#primary #weight').text(`${parseFloat(parseFloat(weight).toFixed(1))}/${maxWeight}kg`);
                    var percentage = 100 * (weight / maxWeight);
                    $('#primary #weight-divider').css('background-image', `linear-gradient(to right, red ${percentage}%, transparent ${percentage}%), url(images/divider.png)`);
                } else {
                    var oldText = $('#primary #weight').text();
                    var maxWeight = oldText.split('/')[1];
                    maxWeight = maxWeight.replace('kg', '');
                    $('#primary #weight').text(`${parseFloat(parseFloat(weight).toFixed(1))}/${maxWeight}kg`);
                    var percentage = 100 * (weight / maxWeight);
                    $('#primary #weight-divider').css('background-image', `linear-gradient(to right, red ${percentage}%, transparent ${percentage}%), url(images/divider.png)`);
                }
            }

            drawPrimary();
            drawHotbar();
        }

        if (event.data.secondarySlots) {
            $.each(event.data.secondarySlots, function(slotId, Slot) {

                if (Slot.amount[0] > 0) {
                    secondaryItemList[slotId] = Slot;
                } else {
                    delete secondaryItemList[slotId];
                }

            });

            if (event.data.secondaryWeight != undefined) {
                var weight = event.data.secondaryWeight.toFixed(1);
                var maxWeight = event.data.secondaryMaxWeight;
                if (maxWeight != undefined) {
                    $('#secondary #weight').text(`${weight}/${maxWeight}kg`);
                    var percentage = 100 * (weight / maxWeight);
                    $('#secondary #weight-divider').css('background-image', `linear-gradient(to right, red ${percentage}%, transparent ${percentage}%), url(images/divider.png)`);
                } else {
                    var oldText = $('#primary #weight').text();
                    maxWeight = oldText.split('/')[1];
                    maxWeight = maxWeight.replace('kg', '');
                    $('#secondary #weight').text(`${weight}/${maxWeight}kg`);
                    var percentage = 100 * (weight / maxWeight);
                    $('#secondary #weight-divider').css('background-image', `linear-gradient(to right, red ${percentage}%, transparent ${percentage}%), url(images/divider.png)`);
                }
            }

            drawSecondary();
        }

        if (!$('#secondary').is(":hidden")) {
            $(".helper").html("Basta arrastar o item ao proximo inventário para despejar.");
        } else {
            $(".helper").html("Siga as legendas apresentadas no canto inferior direito.");
        }
    }
});

var primaryCategoriesIndex = 1;
var secondaryCategoriesIndex = 1;

function previousCategory() {

    let isPrimary = false;
    if ($('.focus').attr('id') === 'primary') {
        isPrimary = true;
    }

    let parentInventoryId = 'primary-inventory';
    let categoryElement;

    if (!(isPrimary)) {
        parentInventoryId = 'secondary-inventory';

        if (secondaryCategoriesIndex != 1) {
            secondaryCategoriesIndex--;
        } else {
            secondaryCategoriesIndex = 9;
        }
        categoryElement = $(`#${parentInventoryId} .item-categories-container .icon:nth-child(${secondaryCategoriesIndex}`);
        $(`#${parentInventoryId} .slot-container`).html('');
        drawSecondary();
    } else {
        if (primaryCategoriesIndex != 1) {
            primaryCategoriesIndex--;
        } else {
            primaryCategoriesIndex = 8;
        }
        categoryElement = $(`#${parentInventoryId} .item-categories-container .icon:nth-child(${primaryCategoriesIndex}`);
        $(`#${parentInventoryId} .slot-container`).html('');
        drawPrimary();
    }

    $(`#${parentInventoryId} .enabled`).removeClass('enabled');
    $(categoryElement).addClass('enabled');
    $(`#${parentInventoryId} .control-info-container #selected-category`).text($(categoryElement).attr('data-name'));
}

function nextCategory() {

    let isPrimary = false;
    if ($('.focus').attr('id') === 'primary') {
        isPrimary = true;
    }

    let parentInventoryId = 'primary-inventory';
    let categoryElement;

    if (!(isPrimary)) {
        parentInventoryId = 'secondary-inventory';
        if (secondaryCategoriesIndex != 9) {
            secondaryCategoriesIndex++;
        } else {
            secondaryCategoriesIndex = 1;
        }
        categoryElement = $(`#${parentInventoryId} .item-categories-container .icon:nth-child(${secondaryCategoriesIndex}`);
        $(`#${parentInventoryId} .slot-container`).html('');
        drawSecondary();
    } else {
        if (primaryCategoriesIndex != 8) {
            primaryCategoriesIndex++;
        } else {
            primaryCategoriesIndex = 1;
        }
        categoryElement = $(`#${parentInventoryId} .item-categories-container .icon:nth-child(${primaryCategoriesIndex}`);
        $(`#${parentInventoryId} .slot-container`).html('');
        drawPrimary();
    }

    $(`#${parentInventoryId} .enabled`).removeClass('enabled');
    $(categoryElement).addClass('enabled');
    $(`#${parentInventoryId} .control-info-container #selected-category`).text($(categoryElement).attr('data-name'));
}

$(document).ready(function() {

    $(document).keyup(function(event) {
        if (event.which == shortcutPressed) {

            if (shortcutPressed === 17) { // L CTRL
                setDescriptionDisplayType(0);
            }

            shortcutPressed = null;
        }
    });

    $(document).keydown(function(event) {
        if (event.which == 16) { // SHIFT
            shortcutPressed = 16; // SHIFT
        }

        if (event.which == 17) { // L CTRL
            shortcutPressed = 17; // L CTRL

            if ($('.selected').length > 0) {
                setDescriptionDisplayType(1);
            }
        }

        if (event.which == 81) { // Q
            previousCategory();
        }

        if (event.which == 69) { // E
            nextCategory();
        }

        if (event.which == 27) { // ESC
            closeInventory();
        }


        if (event.which == 37) { // LEFT ARROW
            if ($('#primary').hasClass('focus')) {
                if (primaryCategoriesIndex != 1) {
                    var selected = $('#primary-inventory .slot-container .slot')
                    $.each(selected, function(index, item) {
                        if (!$(this).hasClass('empty')) {
                            if ($(this).hasClass('selected')) {
                                setTimeout(() => { select($(this).prev()) }, 0)
                            }
                        }
                    });
                }
            } else if ($('#secondary').hasClass('focus')) {
                if (secondaryCategoriesIndex != 1) {
                    var selected = $('#secondary-inventory .slot-container .slot')
                    $.each(selected, function(index, item) {
                        if (!$(this).hasClass('empty')) {
                            if ($(this).hasClass('selected')) {
                                setTimeout(() => { select($(this).prev()) }, 0)
                            }
                        }
                    });
                }
            }
        }

        if (event.which == 39) { // RIGHT ARROW
            if ($('#primary').hasClass('focus')) {
                if (primaryCategoriesIndex != 1) {
                    var selected = $('#primary-inventory .slot-container .slot')
                    $.each(selected, function(index, item) {
                        if (!$(this).hasClass('empty')) {
                            if ($(this).hasClass('selected')) {
                                if (!$(this).next().hasClass('empty')) {
                                    setTimeout(() => { select($(this).next()) }, 0)
                                }
                            }
                        }
                    });
                }
            } else if ($('#secondary').hasClass('focus')) {
                var selected = $('#secondary-inventory .slot-container .slot')
                $.each(selected, function(index, item) {
                    if (!$(this).hasClass('empty')) {
                        if ($(this).hasClass('selected')) {
                            if (!$(this).next().hasClass('empty')) {
                                setTimeout(() => { select($(this).next()) }, 0)
                            }
                        }
                    }
                });
            }
        }

        if (event.which == 65) {
            if (primaryCategoriesIndex != 1) {
                let amount = 1;
                $.post('http://frp_inventory/useItem', JSON.stringify({
                    slot: $('.focus .selected').attr('id'),
                    itemAmount: amount,
                }));
            }
        }

        if (event.which == 68) {
            if (primaryCategoriesIndex != 1) {
                let amount = 1;
                $.post('http://frp_inventory/dropItem', JSON.stringify({
                    slot: $('.focus .selected').attr('id'),
                    itemAmount: 1,
                }));
            }
        }

    });

    $('.hotbar .slot').not('#unarmed').droppable({
        tolerance: 'pointer',
        hoverClass: 'ab',
        accept: function(e) {
            if (e.parent().parent().attr('id') === 'primary-inventory') {
                return true;
            }
        },
        drop: function(event, ui) {


            $(ui.helper).remove();
            let selfSlot = $(this).attr('id');
            let draggableSlot = $(ui.draggable).attr('id');

            if (shortcutPressed == null) {
                itemAmount = -2; // quantidade = TODOS
            }

            if (shortcutPressed == 16) { // SHIFT
                itemAmount = -1
            }

            if (shortcutPressed == 17) { // CTRL
                itemAmount = 1;
            }

            if ($(ui.helper).parent().parent().attr('id') == 'secondary') {
                $.post('http://frp_inventory/moveSlotToPrimary', JSON.stringify({
                    slotFrom: draggableSlot,
                    slotTo: selfSlot,
                    itemAmount: itemAmount,
                }));
            } else {
                $.post('http://frp_inventory/primarySwitchSlot', JSON.stringify({
                    slotFrom: draggableSlot,
                    slotTo: selfSlot,
                    itemAmount: itemAmount,
                }));
            }
        },
    });

    $('#primary').on('mouseover', function() {
        $('.focus').removeClass('focus');
        $('#primary').addClass('focus');
    });

    $('.hotbar').on('mouseover', function() {
        $('.focus').removeClass('focus');
        $('#primary').addClass('focus');
    });

    $('#secondary').on('mouseover', function() {
        $('.focus').removeClass('focus');
        $('#secondary').addClass('focus');
    });
});


function elementAsDraggable(element, a, b, c, d, e, f) {
    element.attr('itemId', a);
    element.attr('title', b);
    element.attr('description', c);

    if (d != null) {
        element.attr('desc_1', d);
        element.attr('desc_2', e);
    }
    
    if (f) {
        element.attr('info', JSON.stringify(f));
    }
    

    element.draggable({
        appendTo: 'body',
        scroll: false,
        revert: true,
        revertDuration: 200,
        helper: 'clone',
        zIndex: 99999,
        start: function(event, ui) {

            ui.helper.css('position', 'absolute');
            ui.helper.css('font-size', '8px');

            $(ui.helper).find('.number').remove();
            $(ui.helper).find('.counter').css('font-size', '8px');
            $(ui.helper).find('.counter').css('color', 'white');

            var imgElement = $(ui.helper).find('img')
            imgElement.css('width', '70px');

            $(this).draggable('instance').offset.click = {
                left: Math.floor(70 / 2),
                top: Math.floor(70 / 2)
            };

            select($(this));
        },
        stop: function(event, ui) {
            if (hasItemDropCooldown == false) {
                let slotId = $(this).attr('id')
                var elemAtMouse = document.elementFromPoint(mouseX, mouseY); // x, y
                var elemAtHelper = document.elementFromPoint(ui.position.left, ui.position.top);

                if ($(elemAtMouse).is("body") && $(elemAtHelper).is("body")) {
                    $.post('http://frp_inventory/drop', JSON.stringify({
                        slotId: $(this).attr('id'),
                    }));
                    hasItemDropCooldown = true;
                    setTimeout(function() {
                        hasItemDropCooldown = false;
                    }, 1000);
                }
            }

            // select($(this));
            // unSelect($(this));
        },
    });
}

function slotsAsFakeDroppable() {
    $(`#primary-inventory .slot-container .slot`).droppable({
        tolerance: 'pointer',
        activeClass: 'blocked',
    });
}

function drawHotbar() {

    for (var slotId = 129; slotId <= 132; slotId++) {
        var Slot = primaryItemList[slotId];

        $(`#primary .hotbar #${slotId}`).children().filter(":not(.number)").remove();

        if (Slot != undefined) {
            var itemId = Slot.name;
            // var itemAmount = Slot[2];
            var ammoInClip = Slot.amount[1];
            var ammoInWeapon = Slot.amount[2];

            var metaInfo = Slot.info;

            // var itemStackSize = Slot.itemStackSize;
            var itemName = Slot.itemName;
            var itemDescription = Slot.itemDescription;

            // $(`#primary .hotbar #${slotId}`).html('');

            $(`#primary .hotbar #${slotId}`).removeClass('empty');

            if (itemId != 'lasso') {
                $(`#primary .hotbar #${slotId}`).append(`
                    <img src="images/items/${itemId}.png" onerror="this.src='images/_placeholder.png'">
                    <div class="counter">${ammoInClip}/${ammoInWeapon}</div>
                `);
            } else {
                $(`#primary .hotbar #${slotId}`).append(`
                    <img src="images/items/${itemId}.png" onerror="this.src='images/_placeholder.png'">
                `);
            }

            var element = $(`#primary .hotbar #${slotId}`);
            elementAsDraggable(element, itemId, itemName, itemDescription, metaInfo);
        } else {
            $(`#primary .hotbar #${slotId}`).addClass("empty");
            $(`#primary .hotbar #${slotId}`).removeAttr('itemId');
        }
    }

    if ($('.hotbar-slot-selected').length > 0) {
        let element = $(`.hotbar-slot-selected`);
        // let selectedSlotId = $(element).attr('id');

        let itemId = $(element).attr('itemId');

        $.post('http://frp_inventory/interactWithHotbarSlot', JSON.stringify({
            itemId: itemId,
        }));
    }
}

function drawPrimary() {
    $(`#primary-inventory .description-amount`).text('');
    $(`#primary-inventory .description-title`).text('');
    $(`#primary-inventory .description-description`).text('');
    $(`#primary-inventory .item-info`).text('');

    $(`#primary-inventory .slot-container`).html('');

    // $(`#range-input`).attr('step', 1);

    setDescriptionDisplayType(0);

    $('.hotbar').fadeIn(500);
    var money = 0;
    var Loop = 1;
    var slotIdItem;

    var loopOn = false;

    for (var slotId = (primaryCategoriesIndex * 16) - 15; slotId < (primaryCategoriesIndex * 16) + 1; slotId++) {
        var Slot = primaryItemList[slotId];    
        
        if (primaryCategoriesIndex == 1) {          
            if (!loopOn) {
                for (var slotIdItem = 17; slotIdItem < 128; slotIdItem++) {
                    if (primaryItemList[slotIdItem]) {
                        Loop = Loop + 1;
                        primaryItemList[Loop] = primaryItemList[slotIdItem];
                    }
                }
                loopOn = true;
            }
        }        

        if (Slot !== undefined && Slot !== null) {               

            var itemId = Slot.name;

            var itemAmount = Slot.amount[0] || Slot.amount;;          

            var ammoInClip = Slot.amount[1]; 
            var ammoInWeapon = Slot.amount[2];

            var metaInfo = Slot.info;   

            if (itemId == 'money' || itemId == 'gold') {
                itemAmount = itemAmount / 100;
                itemAmount = itemAmount.toFixed(2);
            }
            
            var itemStackSize = Slot.itemStackSize;
            var itemName = Slot.itemName;
            var itemDescription = Slot.itemDescription;

            var displayItemAmount = false;
                      

            if (ammoInClip == undefined && ammoInWeapon == undefined) {
                
                if (itemStackSize != -1) {
                    if (itemId != "lasso") {
                        // <div class="counter">${itemAmount}/${itemStackSize}</div>
                        $(`#primary-inventory .slot-container`).append(`
                            <div class="slot" id="${slotId}" onclick="select(this)">
                                <img src="images/items/${itemId}.png" onerror="this.src='images/_placeholder.png'">
                            </div>
                        `);
                        displayItemAmount = true;
                    } else {
                        $(`#primary-inventory .slot-container`).append(`
                            <div class="slot" id="${slotId}" onclick="select(this)">
                                <img src="images/items/${itemId}.png" onerror="this.src='images/_placeholder.png'">
                            </div>
                        `);
                    }
                    
                } else {
                    // 
                    $(`#primary-inventory .slot-container`).append(`
                        <div class="slot" id="${slotId}" onclick="select(this)">
                            <img src="images/items/${itemId}.png" onerror="this.src='images/_placeholder.png'">
                            <div class="counter">${itemAmount}</div>
                        </div>
                    `);
                    displayItemAmount = true;
                    itemStackSize = null;
                }
            } else {
                $(`#primary-inventory .slot-container`).append(`
                    <div class="slot" id="${slotId}" onclick="select(this)">
                        <img src="images/items/${itemId}.png" onerror="this.src='images/_placeholder.png'">
                        <div class="counter">${ammoInClip}/${ammoInWeapon}</div>
                    </div>
                `);
            }

            var element = $(`#primary-inventory .slot-container #${slotId}`);

            if (primaryCategoriesIndex != 0) {

                if (displayItemAmount == false) {
                    itemAmount = null;
                    itemStackSize = null;
                }
                
                elementAsDraggable(element, itemId, itemName, itemDescription, itemAmount, itemStackSize, metaInfo);

                // $(`#primary-inventory .slot-container #${slotId}`).dblclick(function() {
                //     let selfSlot = $(this).attr('id');
                //     $.post('http://frp_inventory/use', JSON.stringify({
                //         slotId: selfSlot,
                //     }));
                // })

                $(`#primary-inventory .slot-container #${slotId}`).mouseup(function(evt) {
                    if (evt.originalEvent.detail === 2) { // Double right-click
                        switch (evt.which) {
                            case 1: // left-click
                                var selfSlot = $(this).attr('id');
                                $.post('http://frp_inventory/use', JSON.stringify({
                                    slotId: selfSlot,
                                }));
                                break
                            case 3: // right-click
                                select(this);
                                var selfSlot = $(this).attr('id');
                                $.post('http://frp_inventory/startsendingslot', JSON.stringify({
                                    slotId: selfSlot,
                                }));
                                break
                        }
                    }
                });
            }
        } else {
            $("#primary-inventory .slot-container").append(`
                <div class="slot empty" id="${slotId}">
                </div>
            `);
        }

        if (primaryCategoriesIndex == 1) {
            slotsAsFakeDroppable();
        }
    }

    var currency1 = 0;
    var currency2 = 0;

    var haveMoney = false;
    var haveGold = false;

    $.each(primaryItemList, function(slot, Slot) {
        if (Slot != undefined) {

            var itemName = Slot.name;
            var itemAmount = parseInt(Slot.amount);

            if (itemName == 'gold' && !haveGold) {
                currency1 = parseInt(currency1) + itemAmount;
                haveGold = true;
            } else if (itemName == 'money' && !haveMoney) {
                currency2 = parseInt(currency2) + itemAmount;     
                haveMoney = true;    
            } 
        }
    });

    currency1 = currency1 / 100;
    currency2 = currency2 / 100;

    $('#primary #currency1').text(currency1.toFixed(2));
    $('#primary #currency2').text(currency2.toFixed(2));    

    if (primaryCategoriesIndex != 1) {
        $(`#primary-inventory .slot-container`).children().droppable({
            tolerance: 'pointer',
            hoverClass: 'ab',
            drop: function(event, ui) {
                $(ui.helper).remove();
                // let valueCount = $('.count').value;
                let selfSlot = $(this).attr('id');
                let draggableSlot = $(ui.draggable).attr('id');

                if (shortcutPressed == null) {
                    itemAmount = -2; // quantidade = TODOS
                }

                if (shortcutPressed == 16) { // SHIFT
                    itemAmount = -1;
                }

                if (shortcutPressed == 17) { // CTRL
                    itemAmount = lastRangeValue;
                    lastRangeValue = 1;
                }

                if ($(ui.draggable).parent().parent().attr('id') == 'secondary-inventory') {
                    $.post('http://frp_inventory/moveSlotToPrimary', JSON.stringify({
                        slotId: draggableSlot,
                        itemAmount: itemAmount,
                    }));
                } else {
                    $.post('http://frp_inventory/primarySwitchSlot', JSON.stringify({
                        slotFrom: draggableSlot,
                        slotTo: selfSlot,
                        itemAmount: itemAmount,
                    }));
                }
            },

        });
    }
}

function drawSecondary() {
    $(`#secondary-inventory .description-amount`).text('');
    $(`#secondary-inventory .description-title`).text('');
    $(`#secondary-inventory .description-description`).text('');
    $(`#secondary-inventory .item-info`).text('');

    $(`#secondary-inventory .slot-container`).html('');
    var money = 0;

    let firstSlot = (secondaryCategoriesIndex * 16) - 15;
    let lastSlot = (secondaryCategoriesIndex * 16) + 1;

    if (firstSlot == 129){
        lastSlot = 132 + 1;
    }

    for (var slotId = firstSlot; slotId < lastSlot; slotId++) {
        var Slot = secondaryItemList[slotId];
        if (Slot !== undefined && Slot !== null) {
            var itemId = Slot.name;
            var itemAmount = Slot.amount[0] || Slot.amount;;
            var ammoInClip = Slot.amount[1];
            var ammoInWeapon = Slot.amount[2];

            var metaInfo = Slot.info;

            if (itemId == 'money' || itemId == 'gold') {
                itemAmount = itemAmount / 100;
                itemAmount = itemAmount.toFixed(2);
            }

            var itemStackSize = Slot.itemStackSize;
            var itemName = Slot.itemName;
            var itemDescription = Slot.itemDescription;

            var displayItemAmount = false;

            if (ammoInClip == undefined && ammoInWeapon == undefined) {
                if (itemStackSize != -1) {
                    if (itemId != "lasso") {
                        $(`#secondary-inventory .slot-container`).append(`
                    <div class="slot" id="${slotId}" onclick="select(this)">
                        <img src="images/items/${itemId}.png" onerror="this.src='images/_placeholder.png'">
                        <div class="counter">${itemAmount}/${itemStackSize}</div>
                    </div>
                `);
                        displayItemAmount = true;
                    } else {
                        $(`#secondary-inventory .slot-container`).append(`
                        <div class="slot" id="${slotId}" onclick="select(this)">
                            <img src="images/items/${itemId}.png" onerror="this.src='images/_placeholder.png'">
                        </div>
                    `);
                    }
                } else {
                    $(`#secondary-inventory .slot-container`).append(`
                        <div class="slot" id="${slotId}" onclick="select(this)">
                            <img src="images/items/${itemId}.png" onerror="this.src='images/_placeholder.png'">
                            <div class="counter">${itemAmount}</div>
                        </div>
                    `);
                    displayItemAmount = true;
                    itemStackSize = null;
                }
            } else {
                $(`#secondary-inventory .slot-container`).append(`
                    <div class="slot" id="${slotId}" onclick="select(this)">
                        <img src="images/items/${itemId}.png" onerror="this.src='images/_placeholder.png'">
                        <div class="counter">${ammoInClip}/${ammoInWeapon}</div>
                    </div>
                `);
            }

            var element = $(`#secondary-inventory .slot-container #${slotId}`);

            if (secondaryCategoriesIndex != 1) {

                if (displayItemAmount == false) {
                    itemAmount = null;
                    itemStackSize = null;
                }

                elementAsDraggable(element, itemId, itemName, itemDescription, itemAmount, itemStackSize, metaInfo);
            }
        } else {
            $("#secondary-inventory .slot-container").append(`
                <div class="slot empty" id="${slotId}">
                </div>
            `);
        }

        if (secondaryCategoriesIndex == 1) {
            slotsAsFakeDroppable();
        }
    }

    var currency1 = 0;
    var currency2 = 0;

    var haveMoney = false;
    var haveGold = false;
    
    $.each(secondaryItemList, function(slot, Slot) {
        if (Slot != undefined) {

            var itemName = Slot.name;
            var itemAmount = parseInt(Slot.amount);

            if (itemName == 'gold' && !haveGold) {
                currency1 = parseInt(currency1) + itemAmount;
                haveGold = true;
            } else if (itemName == 'money' && !haveMoney) {
                currency2 = parseInt(currency2) + itemAmount;     
                haveMoney = true;    
            } 
        }
    });

    currency1 = currency1 / 100;
    currency2 = currency2 / 100;

    

    $('#secondary #currency1').text(currency1.toFixed(2));
    $('#secondary #currency2').text(currency2.toFixed(2));

    if (secondaryCategoriesIndex != 1) {
        $(`#secondary-inventory .slot-container`).children().droppable({
            tolerance: 'pointer',
            hoverClass: 'ab',
            drop: function(event, ui) {
                $(ui.helper).remove();
                // let valueCount = $('.count').value;
                let selfSlot = $(this).attr('id');
                let draggableSlot = $(ui.draggable).attr('id');

                if (shortcutPressed == null) {
                    itemAmount = -2; // quantidade = TODOS
                }

                if (shortcutPressed == 16) { // SHIFT
                    itemAmount = -1
                }

                if (shortcutPressed == 17) { // CTRL
                    itemAmount = 1
                }


                if ($(ui.draggable).parent().parent().attr('id') == 'primary-inventory') {
                    $.post('http://frp_inventory/moveSlotToSecondary', JSON.stringify({
                        slotId: draggableSlot,
                        itemAmount: itemAmount,
                    }));
                } else {
                    $.post('http://frp_inventory/secondarySwitchSlot', JSON.stringify({
                        slotFrom: draggableSlot,
                        slotTo: selfSlot,
                        itemAmount: itemAmount,
                    }));
                }

            }
        });
    }
}

function select(element) {
    // let count = $('.count')[0].innerText;
    // $('.count').attr("disabled", false);

    if (($(element).attr('itemId') != undefined)) {
        let elementParentParentId = $(element).parent().parent().attr('id');
        $(`#${elementParentParentId} .description-amount`).text('');
        $(`#${elementParentParentId} .description-title`).text('');
        $(`#${elementParentParentId} .description-description`).text('');        
        $(`#${elementParentParentId} .item-info`).text('');
        
        
        $(`#${elementParentParentId} .selected`).removeClass('selected');
        $(element).addClass('selected');

        var tableInfo = $(element).attr('info');

        // if (tableInfo != undefined) {
        //     for (var [k, v] of Object.entries(JSON.parse(tableInfo))) {
        //         console.log(k);
        //         console.log(v);
        //     }            
        // }

        if(tableInfo != undefined && tableInfo != '[]') {
            var data = {
                name: $(element).attr('itemId'),
                label: $(element).attr('title'),
                info: JSON.parse(tableInfo)
            }
            FormatItemInfo(data, $(element).position());
        }


        $(`#${elementParentParentId} .description-title`).text($(element).attr('title'));

        if ($(element).attr('desc_1') != undefined) {
            if ($(element).attr('desc_2') != undefined) {
                $(`#${elementParentParentId} .description-amount`).html(`${$(element).attr("desc_1")} de ${$(element).attr("desc_2")}`);
            } else {
                $(`#${elementParentParentId} .description-amount`).html(`${$(element).attr("desc_1")}`);
            }
        }

        let min = 1;
        let max = $(element).attr("desc_1");
        let step = 1;

        let itemId = $(element).attr('itemId');
        if (itemId == 'money' || itemId == 'gold') {
            min = 0.01;
            step = 0.01;
        }

        if (min == 0.01 && lastRangeValue == 1) {
            lastRangeValue = 0.01;
        }

        $(`#range-input`).attr({
            "min": min,
            "max": max,
            "step": step,
            "value": min,
        });

        let perc = (min / max) * 100;

        $(`#range-input`).css('background', `linear-gradient(to right, rgba(116, 116, 116, 0.534) ${perc}%, rgba(128, 128, 128, 0.2) ${perc}%)`);

        $("#range-output").text(min);

        $(`#${elementParentParentId} .description-description`).text($(element).attr('description'));
        indexSelected = $(element).attr('id');
    }
}

function unSelect(element) {
    if ($(element).hasClass('selected')) {
        $(element).removeClass('selected');
        let elementParentParentId = $(element).parent().parent().attr('id');
        $(`${elementParentParentId} .description-amount`).text('');
        $(`${elementParentParentId} .description-title`).text('');
        $(`${elementParentParentId} .description-description`).text('');
        $(`#${elementParentParentId} .item-info`).text('');

        setDescriptionDisplayType(0);
    }
}

function isFloat(n) {
    return Number(n) === n && n % 1 !== 0;
}



function FormatItemInfo(itemData, data) {
    $(".ply-iteminfo-container").css({"top":data.top+30});
    $(".ply-iteminfo-container").css({"left":data.left+130});
    
    if (itemData != null && itemData.info != "[]" && itemData.info != undefined) {
    //    $(".item-info").html('<p><strong>ID: </strong><span>' + itemData.info.citizenid + '</span></p><p><strong>Nome: </strong><span>' + itemData.info.firstname + '</span></p><p><strong>Sobrenome: </strong><span>' + itemData.info.lastname + '</span></p><p><strong>Nascimento: </strong><span>' + itemData.info.birthdate + '</span></p><p><strong>Genero: </strong><span>' + gender + '</span></p><p><strong>Cidade Natal: </strong><span>' + itemData.info.nationality + '</span></p>');
        
        for (var [name, info] of Object.entries(itemData.info)) {
            $(".item-info").append(`
                <p><strong>` +name+`: </strong><span>` + info + `</span></p>
            `);
        }
    } 
 }


function closeInventory() {
    $('.hotbar').fadeOut(500);
    $('.selected').removeClass('selected');
    $("#secondary").hide();
    $.post("http://frp_inventory/NUIFocusOff", JSON.stringify({}));
}


// $(function() {
//     $.contextMenu({
//         selector: '.selected',
//         callback: function(key, options) {
//             var m = key;
//             console.log('Click RIGHT')
//                 // colocar aqui a função de click rightc
//                 // console.log($(key).attr('id'));
//                 // // $.post("http://frp_inventory/NUIFocusOff", JSON.stringify({}));
//         },
//         items: {
//             functionDrop: {
//                 name: "Dropar",
//                 icon: "drop",
//                 callback: function(key, opt) {

//                 }
//             },
//         }
//     });
//     $('.selected').on('click', function(e) {
//         // colocar aqui a função de click LEFT
//         // console.log('ye');
//         console.log('CLICK LEFT');
//     })
// });


function setDescriptionDisplayType(type) {
    switch (type) {
        case 0:
            $('.description-range').hide();

            $('.description-description').show();
            break;
        case 1:
            $('.description-description').hide();

            $('.description-range').show();
            break;
        default:
            $('.description-range').hide();

            $('.description-description').show();
            break;
    }
}