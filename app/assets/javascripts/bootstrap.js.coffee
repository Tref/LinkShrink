$(document).on "page:change", ->
  $("#link_full_url").focus ->
    $(this).val("http://")
  $("#link_full_url").blur ->
    if $(this).val() == "http://"
      $(this).val("")
  $('.home-link').hover (->
    $('.home-logo').animate { 'height': '-=20px', 'top': '+=20px' }, 50
    return
  ), ->
    $('.home-logo').animate { 'height': '+=20px', 'top': '-=20px' }, 50
    return
  clip = new ZeroClipboard($('#d_clip_button'))

$(document).on 'click', '#d_clip_button', (e) ->
  $(this).removeClass('btn-info').addClass('btn-success').text("Copied!").effect("highlight", 1500)
  return

$(document).on 'click', '.input-group-copy .fa-times', (e) ->
  $('.main-notice').hide();
  $('.input-group-create, .input-group-copy').toggle()
  $("#link_full_url").val("").focus()

