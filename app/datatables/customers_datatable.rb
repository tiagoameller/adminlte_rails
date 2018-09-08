class CustomersDatatable < ApplicationDatatable
  # delegate :customer_path, to: :@view
  delegate :edit_customer_path, to: :@view
  delegate :fa_icon, to: :@view

  private

  def count
    Customer.count
  end

  def data
    customers.map do |model|
      present(model) do |customer|
        [].tap do |column|
          column << link_to(customer.formatted_custid, customer, data: { id: customer.id })
          column << customer.name.full
          column << customer.email
          column << customer.full_dob
          column << customer.active
          column << customer.notes
          column << link_to(edit_customer_path(customer), class: 'btn btn-warning btn-sm btn_edit') { fa_icon('pencil') }
          column << link_to(
            customer,
            method: :delete,
            data: { confirm: 'Are you sure?', disable_with: '...' },
            class: 'btn btn-danger btn-sm btn_delete'
          ) { fa_icon('trash') }
        end
      end
    end
  end

  def total_entries
    customers.total_count
  end

  def customers
    @customers ||= fetch_customers
  end

  def fetch_customers
    search_value = params[:search][:value] if params.key? :search
    customers = Customer.page(page).per(per_page).order("#{sort_column} #{sort_direction}")
    if search_value
      search_string = []
      columns.each { |term| search_string << "cast(#{term} as varchar) ilike :search" }
      customers.where(search_string.join(' or '), search: "%#{search_value}%") if search_value
    else
      customers
    end
  end

  def columns
    %w(custid first_name last_name email dob active notes)
  end
end
