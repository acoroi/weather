Rails.application.routes.draw do
  # Home page
  root "weather#hello"

  # Custom route(s)
  post "/weather", to: "weather#cities"
end
