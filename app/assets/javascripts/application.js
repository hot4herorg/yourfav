// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap.min
//= require jquery.infinitescroll
//= require masonry.min
//= require imagesLoaded.min
//= require transit.min
//= require jquery.tokeninput
//= require_tree .

// cycle through thumbnails
var thumbSlider = function(thumbClass, containerElem) {
	$('body').on({
		click: function() {
			clearInterval($(this).data('timer'));
		},
		mouseenter: function() {
			var $img, i, slides;
			clearInterval($(this).data('timer'));
			$img = $(this).find(thumbClass);
			slides = $img.data('slides');
			i = 0;
			$(this).data('timer', setInterval((function() {
				$img.attr('src', slides[i]);
				i++;
				if (i === slides.length) {
					i = 0;
				}
			}), 500));
		},
		mouseleave: function() {
			var $img, orig_url;
			clearInterval($(this).data('timer'));
			$img = $(this).find(thumbClass);
			orig_url = $img.data('original');
			$img.attr('src', orig_url);
		}
	}, containerElem);
};

// wiggle animations
var wiggleElem = function(elem) {
	$(elem)
	.transition({rotate: '5deg'}, 100)
	.transition({rotate: '-5deg'}, 100)
	.transition({rotate: '5deg'}, 100)
	.transition({rotate: '-5deg'}, 100)
	.transition({rotate: '0deg'}, 100);
};
