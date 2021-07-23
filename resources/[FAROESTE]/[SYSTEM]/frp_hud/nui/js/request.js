		[].forEach.call(document.querySelectorAll('div'), function(item) {
		  // check if there is a , in the text
		  if (item.innerText.indexOf(',') > -1) {
		    var texts = item.innerText.split(',');
		    item.setAttribute('data-text1', texts[0]);
		    item.setAttribute('data-text2', texts[1]);
		    item.innerHTML = ',';
		  }
		});

			const cType = 2;

			function addCommas(nStr) {
				nStr += '';
				let x = nStr.split('.');
				let x1 = x[0];
				let x2 = x.length > 1 ? '.' + x[1] : '';
				let rgx = /(\d+)(\d{3})/;
				while (rgx.test(x1)) {
					if (!cType || cType === 1)
						x1 = x1.replace(rgx, '$1' + '<span style="margin-left: 3px; margin-right: 3px;"/>' + '$2');
					if (cType === 2)
						x1 = x1.replace(rgx, '$1' + ',' + '$2');
					else
						x1 = x1.replace(rgx, '$1' + ',' + '$2');
				}
				return x1 + x2;
			}

			window.onload = function (e) {
				// NUI Callback
				closebox();
				window.addEventListener('message', function (event) {
					let item = event.data;
			

					if (item.showhud == true) {
						viewbox();
						
					} else if (item.hidehud == true) {					
						closebox();
					} 
					if (item.data.dolar !== null) {
						console.log('setmoney:' + item.data.dolar);
						$("#cash").html("<i></i>" + addCommas(item.data.dolar))+ "</div>";
					} 
					if (item.data.gold !== null) {
						console.log('setgold:' + item.data.gold);
						$("#gold").html("<i></i><div class='gold2'>" + addCommas(item.data.gold)) + "</div>";
					}
					if (item.data.id  !== null) {
						$("#id").html("<i class='fas fa-portrait'></i>" + addCommas(item.data.id));
					} 
					if (item.data.xp  !== null) {
						$("#xp").html("<i></i>" + item.data.xp);
					}
					if (item.data.level !== null) {
						$("#level").html("<i class='fas fa-hat-cowboy'></i>" + addCommas(item.data.level));
					} 
				});
			};

function closebox() { 
	$('#container').fadeOut();
	$('#server').fadeOut();
	//$('#body').fadeOut();
	$("#container").delay(500);
	$("#server").delay(500);
}
function viewbox() { 
	$("#container").delay(500);
	$("#server").delay(500);
	//$("#body").fadeIn();	
	$("#container").fadeIn();
	$("#server").fadeIn();				
	$("#container").delay(5000);
	$("#server").delay(5000);
}

function DrawText(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre, font) {
    SetTextScale(w, h)
    SetTextColor(Math.floor(col1), Math.floor(col2), Math.floor(col3), Math.floor(a))
    SetTextCentre(centre)
    if (enableShadow) {
        SetTextDropshadow(1, 0, 0, 0, 255)
    }
    Citizen.invokeNative('0xADA9255D', font)
    DisplayText(CreateVarString(10, "LITERAL_STRING", str), x, y)
}
