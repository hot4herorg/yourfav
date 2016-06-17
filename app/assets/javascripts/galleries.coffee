# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->

	# focus Add Video input when dropdown is shown
	$('#nav-add-video-text').click ->
		setTimeout('$("#nav_video_url").focus()', 10);
		return

	# load video actions via ajax
	$('body').on 'show.bs.dropdown', '.video-actions', ->
		url = $(this).data('url')
		$(this).find('.dropdown-menu').load(url)
		return
