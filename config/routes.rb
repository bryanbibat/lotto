Lotto::Application.routes.draw do
  post "/" => "home#process_ticket", :as => "tickets"
  root :to => "home#index"
end
