class App.DataTableConfig

  set_selected_id: (value) -> window["##{@selector}_selected_id"] = value

  get_selected_id: -> window["##{@selector}_selected_id"]

  datatable_api: -> @table.dataTable().api()

  constructor: (selector) ->
    self = @
    @selector = selector
    @table = $("##{selector}")
    data_table = self.table.dataTable({
      ajax: self.table.data('url')
      processing: true
      serverSide: true
      lengthChange: true
      ordering: true
      autoWidth: true
      scrollX: true
      stateSave: true
      order: [[0, 'asc']]
      columnDefs: [
        {
          targets: [-1, -2] # last two columns
          orderable: false
          searchable: false
          className: 'text-center'
        }
      ]
      fnPreDrawCallback: (e, settings) ->
        # page length select has up/down and dropdown buttons
        $('select.custom-select').removeClass('custom-select custom-select-sm')
      fnDrawCallback: (data) ->
        $('.btn_edit, .btn_delete').addClass('disabled') if $(this).data('readonly')
        $("##{self.selector} tbody tr").removeClass('table-active')
        # if a row was selected, select and display
        for tr in $("##{self.selector} tbody tr")
          candidate = $(tr).find('td:first >a:first')
          if $(candidate).data('id') == self.datatable_api().state()["#{self.selector}_selected_id"]
            $(tr).addClass('table-active')
            top
            $('html').scrollTop($(tr).offset().top)
            break
      stateSaveCallback: (settings, data) ->
        sessionStorage.setItem('DataTables_' + settings.sInstance, JSON.stringify(data))
      stateLoadCallback: (settings) ->
        JSON.parse(sessionStorage.getItem('DataTables_' + settings.sInstance))
    }).on 'stateSaveParams.dt', (e, settings, data) ->
       # save current selected row for restoring when back
       data["#{self.selector}_selected_id"] = self.get_selected_id()

    # dynamically add a clear filter button
    $("##{@selector}_filter").append(
        "<button class='btn btn-default btn-sm' type='button'>" +
        "<i class='fa fa-times-circle'></i></button>"
    ).on 'click', (e) ->
      $('input[type=search]').val('').focus()
      data_table.fnFilter('')
    $('input[type=search]').css('width', '170px')

    # set active a row when clicked
    $("##{@selector} tbody").on 'click', 'tr', (e) ->
      self.set_selected_id($(this).find('td:first >a:first').data('id'))
      $("##{self.selector} tbody tr").removeClass('table-active')
      $(this).parent().addClass('table-active')
