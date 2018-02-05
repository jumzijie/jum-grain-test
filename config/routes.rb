Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'orders#home'
  get 'orders' => 'orders#index'
  get 'orders/:order_id' => 'orders#show'

  get 'orders/:order_id/feedbacks' => 'orders#feedbacks'
  post 'orders/:order_id/feedbacks' => 'orders#submit_feedbacks'
end
