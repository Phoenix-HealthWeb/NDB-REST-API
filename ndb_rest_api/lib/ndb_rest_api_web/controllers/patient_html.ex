defmodule NdbRestApiWeb.PatientHTML do
  use NdbRestApiWeb, :html

  embed_templates "patient_html/*"

  @doc """
  Renders a patient form.
  """
  attr :changeset, Ecto.Changeset, required: true
  # attr :patients, :list, required: true
  attr :genders, :list, required: true
  attr :action, :string, required: true

  def patient_form(assigns)
end
