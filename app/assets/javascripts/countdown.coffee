$(document).on 'turbolinks:load', ->
	countDownDate = new Date('Sep 5, 2018 15:37:25').getTime()
	# Update the count down every 1 second
	$('.time-left').each (index) ->
		deadline = new Date($(this).data('deadline')).getTime()
		$(this).countdown deadline, (event) ->
	  	$(this).text event.strftime('%D\d %H:%M:%S')
