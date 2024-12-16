defmodule NdbRestApiWeb.ConditionController do
  use NdbRestApiWeb, :controller

  alias NdbRestApi.Conditions
  alias NdbRestApi.Conditions.Condition
  alias NdbRestApi.Repo
  alias NdbRestApi.Patients
  alias NdbRestApi.Practitioners

  def index(conn, _params) do
    conditions =
      Conditions.list_conditions()
      |> Repo.preload(:patient)
      |> Repo.preload(:practitioner)

    render(conn, :index, conditions: conditions)
  end

  def new(conn, _params) do
    changeset = Conditions.change_condition(%Condition{})
    patients = Patients.list_patients()
    practitioners = Practitioners.list_practitioners()
    render(conn, :new, changeset: changeset, patients: patients, practitioners: practitioners)
  end

  def create(conn, %{"condition" => condition_params}) do
    case Conditions.create_condition(condition_params) do
      {:ok, condition} ->
        conn
        |> put_flash(:info, "Condition created successfully.")
        |> redirect(to: ~p"/conditions/#{condition}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    condition =
      Conditions.get_condition!(id)
      |> Repo.preload(:patient)
      |> Repo.preload(:practitioner)

    render(conn, :show, condition: condition)
  end

  def edit(conn, %{"id" => id}) do
    condition = Conditions.get_condition!(id)
    patients = Patients.list_patients()
    practitioners = Practitioners.list_practitioners()
    changeset = Conditions.change_condition(condition)

    render(conn, :edit,
      condition: condition,
      changeset: changeset,
      patients: patients,
      practitioners: practitioners
    )
  end

  def update(conn, %{"id" => id, "condition" => condition_params}) do
    condition = Conditions.get_condition!(id)

    case Conditions.update_condition(condition, condition_params) do
      {:ok, condition} ->
        conn
        |> put_flash(:info, "Condition updated successfully.")
        |> redirect(to: ~p"/conditions/#{condition}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, condition: condition, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    condition = Conditions.get_condition!(id)
    {:ok, _condition} = Conditions.delete_condition(condition)

    conn
    |> put_flash(:info, "Condition deleted successfully.")
    |> redirect(to: ~p"/conditions")
  end
end
