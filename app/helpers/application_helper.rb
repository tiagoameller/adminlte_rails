module ApplicationHelper
  def format_date(date)
    date.present? ? I18n.l(date, format: '%0d/%0m/%Y') : I18n.t('views.undefined')
  end

  def format_date_time_for_sort(date_time)
    date_time.present? ? I18n.l(date_time, format: '%Y%0m%0d%H%M%S') : 99_999_999_999_999
  end

  def format_date_time(date_time)
    date_time.present? ? I18n.l(date_time, format: '%0d/%0m/%Y %H:%M') : I18n.t('views.undefined')
  end

  def bwz(value)
    value if value && value != 0
  end

  def number_to_currency_dwz(value)
    # dash when zero
    value && value != 0 ? ApplicationController.helpers.number_to_currency(value) : '-'
  end

  def number_to_currency_no_unit(value)
    # "123.456,70"
    ApplicationController.helpers.number_to_currency(value, format: '%n')
  end
end
