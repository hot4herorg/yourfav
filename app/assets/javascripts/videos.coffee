# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->

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

	# destroy remote modals after hidden
	$('body').on 'hide.bs.modal', '.modal-refresh', ->
		$(this).removeData 'bs.modal'
		$(this).find('.modal-dialog').remove()
		return

	# cycle thumbs on hover
	$('body').on {
		click: ->
			clearInterval $(this).data('timer')
			return
		mouseenter: ->
			clearInterval $(this).data('timer')
			$img = $(this).find('.video-thumb')
			slides = $img.data('slides')
			i = 0
			$(this).data 'timer', setInterval((->
				$img.attr('src', slides[i])
				i++
				i = 0 if i == slides.length
				return
			), 500)
			return
		mouseleave: ->
			clearInterval $(this).data('timer')
			$img = $(this).find('.video-thumb')
			orig_url = $img.data('original')
			$img.attr('src', orig_url)
			return
	}, '#videos > .video > .panel'
