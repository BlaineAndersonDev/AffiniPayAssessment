Rails.application.routes.draw do
  root 'calclient#index'
  get 'calclient/call'
  post 'calclient/call', as: '/call'

end
