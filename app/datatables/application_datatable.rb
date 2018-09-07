class ApplicationDatatable
  delegate :params, to: :@view
  delegate :link_to, to: :@view
  delegate :content_tag, to: :@view
  delegate :present, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(_options = {})
    {
      recordsTotal: count,
      recordsFiltered: total_entries,
      data: data
    }
  end

  private

  def sort_column
    columns[params.dig(:order, '0', :column).to_i]
  end

  def sort_direction
    params.dig(:order, '0', :dir) == 'desc' ? 'desc' : 'asc'
  end

  def page
    params[:start].to_i / per_page + 1
  end

  def per_page
    params[:length].to_i > 0 ? params[:length].to_i : 10
  end
end
