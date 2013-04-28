// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(function(){
	$("[data-logo]").each(function(i) {
		var $e = $(this);
		$.getJSON("https://ajax.googleapis.com/ajax/services/search/images?callback=?&v=1.0&q=" + $(this).text(), function(data) {
			var img = data['responseData']['results'][0]['url'],
				nextImg = data['responseData']['results'][1]['url'],
				$i = $('<img/>');

			$i.on('error', function(e){
				$(this).attr('src', nextImg);
				$i.off('error');
			});
			$i.attr('src', img).attr('class', 'web-image');
			$e.before($i);
		});
	});
});