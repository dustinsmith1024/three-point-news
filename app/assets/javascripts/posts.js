// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$('img').on('error', function(e){
	console.log('error loading', this.src);
	var src = $(this).attr('src');
	if(src.indexOf('800') !== -1){
		src = src.replace('800', '600');
		$(this).attr('src', src);
		return true;
	}
	if(src.indexOf('600') !== -1){
		src = src.replace('600', '400');
		$(this).attr('src', src);
		return true;
	}
	if(src.indexOf('400') !== -1){
		src = src.replace('400', '300');
		$(this).attr('src', src);
		return true;
	}
	if(src.indexOf('300') !== -1){
		src = src.replace('300', '200');
		$(this).attr('src', src);
		return true;
	}
});