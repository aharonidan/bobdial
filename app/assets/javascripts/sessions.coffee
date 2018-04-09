# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('.navbar-item').each (e) ->
    $(this).click ->
      if $('#navbar-burger-id').hasClass('is-active')
        $('#navbar-burger-id').removeClass 'is-active'
        $('#navbar-menu-id').removeClass 'is-active'
      return
    return
  # Open or Close mobile & tablet menu
  $('#navbar-burger-id').click ->
    if $('#navbar-burger-id').hasClass('is-active')
      $('#navbar-burger-id').removeClass 'is-active'
      $('#navbar-menu-id').removeClass 'is-active'
    else
      $('#navbar-burger-id').addClass 'is-active'
      $('#navbar-menu-id').addClass 'is-active'
    return