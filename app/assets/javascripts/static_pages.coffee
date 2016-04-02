# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->

	$('[data-toggle="popover"]').popover()
	$('[data-toggle="tooltip"]').tooltip()

	# destroy remote modals after hidden
	$('body').on 'hide.bs.modal', '.modal-refresh', ->
		$(this).removeData 'bs.modal'
		$(this).find('.modal-dialog').remove()
		return
