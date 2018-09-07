class CustomerPresenter < ApplicationPresenter
  def formatted_custid
    format('%05d', @model.custid)
  end

  def full_dob
    I18n.l(@model.dob, format: '%a, %e/%b/%Y')
  end
end
