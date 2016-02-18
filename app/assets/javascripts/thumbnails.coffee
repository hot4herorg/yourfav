# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->

	# switch class when file is chosen
	$('body').on 'change', '.btn-file input[type=file]', (e) ->
		$btn = $(this).closest('.btn-file')
		if $(this).val().length
			$btn.removeClass('btn-default').addClass('btn-success')
		else
			$btn.removeClass('btn-success').addClass('btn-default')