defmodule NdbRestApiWeb.AdminRegistrationController do
  use NdbRestApiWeb, :controller

  alias NdbRestApi.Accounts
  alias NdbRestApi.Accounts.Admin
  alias NdbRestApiWeb.AdminAuth

  def new(conn, _params) do
    changeset = Accounts.change_admin_registration(%Admin{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"admin" => admin_params}) do
    case Accounts.register_admin(admin_params) do
      {:ok, admin} ->
        {:ok, _} =
          Accounts.deliver_admin_confirmation_instructions(
            admin,
            &url(~p"/admins/confirm/#{&1}")
          )

        conn
        |> put_flash(:info, "Admin created successfully.")
        |> AdminAuth.log_in_admin(admin)

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end
end
