$ ->
  $('#dataload_ga_ga_account_id').live('change', (e)->
    value = $(e.target).val()
    $('.profile_container').hide()
    unless value == ''
      $('.profile_selector[rel='+value+']').val('')
      $('.profile_container[rel='+value+']').show()
  )