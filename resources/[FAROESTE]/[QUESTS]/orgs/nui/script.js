document.addEventListener("DOMContentLoaded", function() {
    $("body").hide();
});

window.addEventListener("message", function(event) {

    const evdata = event.data;

    switch (evdata.type) {
        case "show":
            $("body").show();

            const orgs_data = evdata.data.orgs;

            const my_member_id = evdata.data.my_member_id;

            $(".container .org").not(":first-child()").remove();

            orgs_data.forEach(x => {

                const org_id = x.org_id;
                const org_name = x.org_name;
                const org_type = x.org_type;

                const my_rank = x.my_rank;

                const org_members = x.members;
                const num_members = org_members.length;

                const im_allowed_to_delete = (org_type == "ilegal" && my_rank == 1);
                const im_allowed_to_edit = my_rank == 1;

                $(".container").append(`
                <div class="org" id="${org_id}">
                    <div class="header">
                        <span>${org_name}</span>
                        <span>${num_members}/5</span>
                        ${GetElement_Delete(org_id, im_allowed_to_delete)}
                    </div>
                    <div class="member-list">
                    </div>
                </div>
                `);

                org_members.forEach(y => {

                    const member_id = y.member_id;
                    const member_rank = y.member_rank;
                    const member_rank_name = y.member_rank_name;
                    const member_name = y.member_name;

                    $(`#${org_id} .member-list`).append(`
                    <div class="member">
                        <div class="info">
                            ${GetElement_Rank(org_type, member_rank, member_rank_name)}
                            <span>${member_name}</span>
                        </div>
                        ${GetElement_RankButtons(org_id, im_allowed_to_edit, my_member_id, member_id, member_rank)}
                        ${GetElement_KickOrLeave(org_id, im_allowed_to_edit, my_member_id, member_id, member_rank)}
                    </div>
                    `);
                });

            });

            break
        case "hide":

            $("body").fadeOut();

            break;
        case "data":

            break;
    }
});

$(document).on("click", ".org .header", function() {

    const parent = $(this).parent();

    const selectedOrgId = $(".org.selected").attr("id");

    $(".org.selected").removeClass("selected");

    if (selectedOrgId == undefined || selectedOrgId != $(parent).attr("id")) {
        $(parent).addClass("selected");
    }
});

$(document).on("keydown", function(e) {
    if (e.which == 27) { // ESC
        $("body").fadeOut();
        $.post("http://orgs/hide", JSON.stringify({}));
    }
});

function GetElement_Rank(org_type, member_rank, member_rank_name) {
    // if (member_rank == 1 && org_type == "ilegal") {
    //     return "<img src=\"https://cdn.discordapp.com/attachments/710552993635762279/738898761324953781/rating_star.png\"/>"
    // }

    return `<span class=\"rank\">${member_rank_name}</span>`
}

function GetElement_RankButtons(org_id, im_allowed_to_edit, my_member_id, member_id, member_rank) {
    if (im_allowed_to_edit && my_member_id != member_id && member_rank != 1) {

        const onclick_promote = `onclick="out_promote(${org_id}, ${member_id})"`;
        const onclick_demote = `onclick="out_demote(${org_id}, ${member_id})"`;

        return `<div class=\"rank-buttons\"><button ${onclick_promote}>↑</button><button ${onclick_demote}>↓</button></div>`
    }

    return ""
}

function GetElement_KickOrLeave(org_id, im_allowed_to_edit, my_member_id, member_id, member_rank) {
    let kickorleave;

    if (im_allowed_to_edit) {
        kickorleave = true;
    }

    if (my_member_id == member_id) {
        kickorleave = false;
    }

    if (kickorleave != undefined) {

        const onclick_func = kickorleave == true ? `out_kick(${org_id}, ${member_id})` : `out_leave(${org_id})`

        return `<button class=\"outside\" onclick=\"${onclick_func}\">x</button>`
    }

    return ""
}

function GetElement_Delete(org_id, im_allowed_to_delete) {

    if (im_allowed_to_delete) {

        const onclick_func = `onclick="out_delete(${org_id})"`

        return `<button class=\"outside\"${onclick_func}>x</button>`;
    }

    return "";
}

function out_create() {
    $.post("http://orgs/create", JSON.stringify({}));
}

function out_delete(org_id) {
    console.log("delete");

    $.post("http://orgs/delete", JSON.stringify({ org_id: org_id }));
}

function out_kick(org_id, target_member_id) {
    // console.log("kick");

    $.post("http://orgs/kick", JSON.stringify({ org_id: org_id, target_member_id: target_member_id }));
}

function out_leave(org_id) {
    // console.log("leave");

    $.post("http://orgs/leave", JSON.stringify({ org_id: org_id }));
}

function out_promote(org_id, target_member_id) {
    // console.log("promote");

    $.post("http://orgs/promote", JSON.stringify({ org_id: org_id, target_member_id: target_member_id }));
}

function out_demote(org_id, target_member_id) {
    // console.log("demote");

    $.post("http://orgs/demote", JSON.stringify({ org_id: org_id, target_member_id: target_member_id }));
}