$(function(){
	window.onload = (e) => {
		window.addEventListener('message', (event) => {
				if (event.data.type === 1){
				showMap(event.data.showMap)
			}
		});
	};
});
