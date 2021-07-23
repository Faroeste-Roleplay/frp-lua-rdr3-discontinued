window.addEventListener("load", function() {

    var wprompt = new WPrompt();
    wprompt.onClose = function() { $.post("http://_core/prompt", JSON.stringify({ act: "close", result: wprompt.result })); }

    var requestmgr = new RequestManager();
    requestmgr.onResponse = function(id, ok) { $.post("http://_core/request", JSON.stringify({ act: "response", id: id, ok: ok })); }

    //MESSAGES
    window.addEventListener("message", function(evt) { //lua actions
        var data = evt.data;

        if (data.act == "prompt") {
            wprompt.open(data.title, data.text);
        } else if (data.act == "request") {
            requestmgr.addRequest(data.id, data.text, data.time);
        } else if (data.act == "event") {
            if (data.event == "yes") {
                requestmgr.respond(true);
            } else if (data.event == "no") {
                requestmgr.respond(false);
            }
        }
    });
});