Rails.application.routes.draw do
  resource :contests, only: [:create, :show]
end
