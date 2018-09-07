window.App ||= {}

class Page
  controller: (check) ->
    if check
      $('body').data('controller') == check
    else
      $('body').data('controller')

  action: (check) ->
    if check
      $('body').data('action') == check
    else
      $('body').data('action')


@page = new Page

# I18n = {}
# I18n.defaultLocale = 'es'
# I18n.locale = "<%= I18n.locale %>"
# $.datepicker.setDefaults($.datepicker.regional[I18n.locale])

App.init = ->
  self = @
  # main inits
  #
  # sets min-with for body to show footer aligned to bottom
  adminlte.Layout._jQueryInterface.call($('body'))
  # iCheck
  $('.icheck').iCheck {
    checkboxClass: 'icheckbox_square-blue'
    radioClass: 'iradio_square-blue'
    increaseArea: '20%' # optional
  }
  $('.datepicker').datepicker($.datepicker.regional['es'])

  new App.DataTableConfig('customers_table') if page.controller('customers') && page.action('index')

# event binding
$(document).on "turbolinks:load", -> App.init()
