Rails.application.routes.draw do
  get 'admin/index'
  get 'admin/not_found_page'
  get 'admin/error_page'
  get 'admin/blank_page'
  root to: 'admin#index'
end
