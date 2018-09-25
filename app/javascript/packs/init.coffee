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


# I18n = {}
# I18n.defaultLocale = 'es'
# I18n.locale = "<%= I18n.locale %>"
# $.datepicker.setDefaults($.datepicker.regional[I18n.locale])

App.init = ->
  self = @
  page = new Page
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

  # Override the default confirm dialog by rails
  $.rails.allowAction = (link) ->
    return true unless link.data('confirm')
    $.rails.showConfirmationDialog link
    false

  # User click confirm button
  $.rails.confirmed = (link) ->
    link.data 'confirm', null
    link.trigger 'click.rails'

  # Display the confirmation dialog
  $.rails.showConfirmationDialog = (link) ->
    message = link.data('confirm')
    swal(
      {
        title: message
        type: 'warning'
        showCancelButton: true
        reverseButtons: true
      }
    ).then (result) ->
      $.rails.confirmed link if result.value

  # page specific js
  new App.DataTableConfig('customers_table') if page.controller('customers') && page.action('index')

# event binding
$(document).on "turbolinks:load", -> App.init()
