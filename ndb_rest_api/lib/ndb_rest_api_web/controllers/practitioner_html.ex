defmodule NdbRestApiWeb.PractitionerHTML do
  use NdbRestApiWeb, :html

  embed_templates "practitioner_html/*"

  @doc """
  Renders a practitioner form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def practitioner_form(assigns)
end
