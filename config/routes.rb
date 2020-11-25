Rails.application.routes.draw do
  root 'calclient#index'
  post 'calclient/call', as: '/call'

end
