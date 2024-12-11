defmodule NdbRestApiWeb.GenderController do
  use NdbRestApiWeb, :controller

  alias NdbRestApi.Genders
  alias NdbRestApi.Genders.Gender

  def index(conn, _params) do
    genders = Genders.list_genders()
    render(conn, :index, genders: genders)
  end

  def new(conn, _params) do
    changeset = Genders.change_gender(%Gender{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"gender" => gender_params}) do
    case Genders.create_gender(gender_params) do
      {:ok, gender} ->
        conn
        |> put_flash(:info, "Gender created successfully.")
        |> redirect(to: ~p"/genders/#{gender}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    gender = Genders.get_gender!(id)
    render(conn, :show, gender: gender)
  end

  def edit(conn, %{"id" => id}) do
    gender = Genders.get_gender!(id)
    changeset = Genders.change_gender(gender)
    render(conn, :edit, gender: gender, changeset: changeset)
  end

  def update(conn, %{"id" => id, "gender" => gender_params}) do
    gender = Genders.get_gender!(id)

    case Genders.update_gender(gender, gender_params) do
      {:ok, gender} ->
        conn
        |> put_flash(:info, "Gender updated successfully.")
        |> redirect(to: ~p"/genders/#{gender}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, gender: gender, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    gender = Genders.get_gender!(id)
    {:ok, _gender} = Genders.delete_gender(gender)

    conn
    |> put_flash(:info, "Gender deleted successfully.")
    |> redirect(to: ~p"/genders")
  end
end
