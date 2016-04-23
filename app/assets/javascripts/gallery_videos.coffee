# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->

	# sort gallery videos
	tableWidthHelper = (e, ui) ->
		ui.children().each ->
			$(this).width $(this).width()
			return
		ui

	$('#gallery_videos').sortable
		placeholder: '.table tr'
		helper: tableWidthHelper
		axis: 'y'
		handle: '.handle'
		update: ->
			console.log('sorted')
			$.post $(this).data('sort-path'), $(this).sortable('serialize')

	# popovers
	$('.gallery-video-thumb').popover
		content: $(this).data('content')
		html: true
		placement: 'left'
		trigger: 'hover'
