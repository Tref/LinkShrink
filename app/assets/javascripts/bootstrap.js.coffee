$(document).on "page:change", ->
  $(".welcome #link_full_url").focus ->
    $(this).val("http://")
  $("#link_full_url").blur ->
    if $(this).val() == "http://"
      $(this).val("")
