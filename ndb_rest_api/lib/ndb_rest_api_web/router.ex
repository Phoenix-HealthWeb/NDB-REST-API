defmodule NdbRestApiWeb.Router do
  use NdbRestApiWeb, :router

  import NdbRestApiWeb.AdminAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {NdbRestApiWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_admin
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", NdbRestApiWeb do
    pipe_through :browser

    get "/", PageController, :home
  end

  # Other scopes may use custom stacks.
  scope "/api", NdbRestApiWeb.Api, as: :api do
    pipe_through :api

    resources "/genders", GenderController
    get "/patients/cf/:cf", PatientController, :get_by_cf
    resources "/patients", PatientController
    resources "/practitioner_roles", PractitionerRoleController
    resources "/hospitals", HospitalController
    post "/hospitals/:id/api_key", HospitalController, :api_key
    resources "/practitioners", PractitionerController
    get "/practitioners/search/:email", PractitionerController, :search
    resources "/medication_requests", MedicationRequestController
    resources "/conditions", ConditionController
    resources "/observations", ObservationController
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:ndb_rest_api, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: NdbRestApiWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  ## Authentication routes

  scope "/", NdbRestApiWeb do
    pipe_through [:browser, :redirect_if_admin_is_authenticated]

    get "/admins/register", AdminRegistrationController, :new
    post "/admins/register", AdminRegistrationController, :create
    get "/admins/log_in", AdminSessionController, :new
    post "/admins/log_in", AdminSessionController, :create
    get "/admins/reset_password", AdminResetPasswordController, :new
    post "/admins/reset_password", AdminResetPasswordController, :create
    get "/admins/reset_password/:token", AdminResetPasswordController, :edit
    put "/admins/reset_password/:token", AdminResetPasswordController, :update
  end

  scope "/", NdbRestApiWeb do
    pipe_through [:browser, :require_authenticated_admin]

    get "/admins/settings", AdminSettingsController, :edit
    put "/admins/settings", AdminSettingsController, :update
    get "/admins/settings/confirm_email/:token", AdminSettingsController, :confirm_email

    resources "/genders", GenderController
    resources "/patients", PatientController
    resources "/practitioner_roles", PractitionerRoleController
    resources "/hospitals", HospitalController
    get "/hospitals/:id/api_key", HospitalController, :api_key
    post "/hospitals/:id/api_key", HospitalController, :api_key
    resources "/practitioners", PractitionerController
    resources "/medication_requests", MedicationRequestController
    resources "/conditions", ConditionController
    resources "/observations", ObservationController
  end

  scope "/", NdbRestApiWeb do
    pipe_through [:browser]

    delete "/admins/log_out", AdminSessionController, :delete
    get "/admins/confirm", AdminConfirmationController, :new
    post "/admins/confirm", AdminConfirmationController, :create
    get "/admins/confirm/:token", AdminConfirmationController, :edit
    post "/admins/confirm/:token", AdminConfirmationController, :update
  end
end
