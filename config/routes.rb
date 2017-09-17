Rails.application.routes.draw do
  get "search", to: "query#search"
  delete "clear_stats", to: "query#destroy_all"
  root to: "query#index"
end
