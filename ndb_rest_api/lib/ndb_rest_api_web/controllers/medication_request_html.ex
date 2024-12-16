defmodule NdbRestApiWeb.MedicationRequestHTML do
  use NdbRestApiWeb, :html

  embed_templates "medication_request_html/*"

  @doc """
  Renders a medication_request form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def medication_request_form(assigns)
end
