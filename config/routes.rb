Rails.application.routes.draw do
  get 'admin/index'

  root to: 'admin#index'
end
