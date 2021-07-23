document.addEventListener("DOMContentLoaded", function(event) {
    $("body").hide();

    $(".main-container").hide();

    $(".top-right-container").hide();
});

window.addEventListener("message", function(event) {

    const evdata = event.data;

    switch (evdata.type) {
        case "show":
            $("body").show();

            if (evdata.data == "unlocks" || evdata.data == "all") {
                $(".main-container").fadeIn();
            }

            if (evdata.data == "info" || evdata.data == "all") {
                $(".top-right-container").fadeIn();
            }
            break
        case "hide":

            if (evdata.data == "unlocks" || evdata.data == "all") {
                $(".main-container").fadeOut();
            }

            if (evdata.data == "info" || evdata.data == "all") {
                $(".top-right-container").fadeOut();
            }

            if (evdata.data == "all") {
                $("body").fadeOut();
            }

            break;
        case "data":

            const unlocks = evdata.unlocks;
            const balance = evdata.balance;

            if (unlocks != undefined) {

                $(".main-container").empty();

                unlocks.forEach(unlockdata => {

                    const id = unlockdata.id;
                    const name = unlockdata.name;
                    const isLocked = unlockdata.is_locked;
                    const isUnowned = unlockdata.is_unowned;

                    let elementClassSuffix = "";

                    if (isLocked == true) {
                        elementClassSuffix = "locked";
                    } else if (isUnowned == true) {
                        elementClassSuffix = "unowned";
                    }

                    console.log(id);



                    $(".main-container").append(`
                    <div class="item ${elementClassSuffix}" id="${id}">
                        <span>${id}</span>
                    </div>
                    `);
                });
            }

            if (balance != undefined) {

                const balance_primary = balance.primary;
                const balance_secondary = balance.secondary;

                $("#p_bal_dollar").text(`$${balance_primary}`);
                $("#p_bal_cents").text("00");

                $("#s_bal_dollar").text(`$${balance_secondary}`);
                $("#s_bal_cents").text("00");
            }

            break;
    }
});