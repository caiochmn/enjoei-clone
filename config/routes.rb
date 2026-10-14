Rails.application.routes.draw do
  root "home#index"

  # Conta
  get    "entrar",   to: "sessions#new",      as: :new_session
  post   "entrar",   to: "sessions#create",   as: :session
  delete "sair",     to: "sessions#destroy",  as: :sign_out
  get    "cadastro", to: "registrations#new",    as: :new_registration
  post   "cadastro", to: "registrations#create", as: :registrations
  resources :passwords, param: :token, path: "senha", only: %i[new create edit update]

  scope "perfil" do
    resource :my_store, path: "minha-lojinha", only: %i[show edit update]
  end

  # Catálogo (a busca de verdade chega na etapa 2)
  get "s", to: "search#index", as: :search
  get "m", to: "brands#index", as: :brands
  get ":department_slug/s", to: "departments#show", as: :department,
    constraints: ->(req) { Category.departments.exists?(slug: req.params[:department_slug]) }

  get "up" => "rails/health#show", as: :rails_health_check

  # Lojinha pública em /{slug}; fica por último para não capturar outras rotas.
  get ":id", to: "stores#show", as: :store, constraints: { id: /[a-z0-9]+(?:-[a-z0-9]+)*/ }
end
