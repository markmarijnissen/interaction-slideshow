(function($){
	window.setTheme = function(theme) {
		$('html').removeClass('beige default moon night serif simple sky solarized');
		$('html').addClass(theme);
	}
})(jQuery)