Rails.application.routes.draw do
  get 'video/visit', to: 'video#visit'
  get 'video/views', to: 'video#views'
  get 'customer/views', to: 'customer#views'
end
