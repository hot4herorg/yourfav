# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->

	# play gfy on hover
	$('body').on
		mouseenter: ->
			$(this).get(0).play()
			return
		mouseleave: ->
			$(this).get(0).pause()
			return
	, '.gfy'

	# star tokens
	$('#video_star_tokens').tokenInput '/stars.json',
		theme: 'bootstrap'
		prePopulate: $('#video_star_tokens').data('load')

	# Masonry + ImagesLoaded + infinitescroll
	$container = $('#videos')
	# Masonry + ImagesLoaded
	$container.imagesLoaded ->
		$container.masonry
			itemSelector: '.video'
			columnWidth: '.video'
		return
	# infinitescroll
	$container.infinitescroll {
		navSelector: '.pagination'
		nextSelector: '.pagination a[rel=next]'
		itemSelector: '.video'
		loading: finishedMsg: 'No more pages to load.'
	}, (newElements) ->
		# hide new items while they are loading
		$newElems = $(newElements).css(opacity: 0)
		# ensure that images load before adding to masonry layout
		$newElems.imagesLoaded ->
			# show elems now they're ready
			$newElems.animate opacity: 1
			$container.masonry 'appended', $newElems, true
			return
		return

	# cycle thumbs on hover
	thumbSlider('.video-thumb', '#videos > .video > .panel')
