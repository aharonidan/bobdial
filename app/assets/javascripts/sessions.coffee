# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('.navbar-item').each (e) ->
    $(this).click ->
      if $('#navbar-burger-id').hasClass('is-active')
        $('#navbar-burger-id').removeClass 'is-active'
        $('#navbar-menu-id').removeClass 'is-active'

  # Open or Close mobile & tablet menu
  $(document).on 'click', '#navbar-burger-id',  ->
    if $('#navbar-burger-id').hasClass('is-active')
      $('#navbar-burger-id').removeClass 'is-active'
      $('#navbar-menu-id').removeClass 'is-active'
    else
      $('#navbar-burger-id').addClass 'is-active'
      $('#navbar-menu-id').addClass 'is-active'

  $(document).on 'click', '.edit-bet', ->
    row = $(this).closest('tr').next('tr')
    row.find('input').attr('disabled', false)
    $(this).find('a').hide()

  $(document).on 'click', '.clickable', ->
    if $(this).data('href')
      window.location = $(this).data('href')

    if $(this).data('edit')
      console.log($(this))
      $(this).find('input').attr('disabled', false)
      $(this).prev().find('a').hide()

  $(document).on 'keyup', '#bets-form input', ->
    row = $(this).closest('tr')
    if row.find('.score_a').val() != '' && row.find('.score_b').val() != ''
      row.find('#submit-bet').css('visibility', 'visible');
    else
      row.find('#submit-bet').css('visibility', 'hidden');

  $('.notification').delay(3000).fadeOut()

$(document).on 'turbolinks:load', ->
  document.getElementById('play').addEventListener 'click', ->
    player = document.getElementById('halau');
    player.src = 'images/halau.mp3;'
    player.play()


