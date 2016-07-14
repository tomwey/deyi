#= require active_admin/base
#= require redactor-rails/redactor
#= require redactor-rails/config
#= require redactor-rails/langs/zh_cn
#= require redactor-rails/plugins

$(document).ready ->
  $('#apartment_rent_type').change ->
    val = $('#apartment_rent_type option:selected').text()
    if val == '单间'
      $('#single-room').show()
    else
      $('#single-room').hide()