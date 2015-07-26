# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->

	# tooltips
	$('[data-toggle="tooltip"]').tooltip()
	$('[data-toggle="popover"]').popover
		trigger: 'hover'

	# destroy remote modals after hidden for refresh
	$('body').on 'hide.bs.modal', '#defaultModal', ->
		$(this).removeData 'bs.modal'
		$(this).find('.modal-dialog').remove()
		return