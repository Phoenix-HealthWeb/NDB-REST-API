defmodule NdbRestApiWeb.PractitionerRoleHTML do
  use NdbRestApiWeb, :html

  embed_templates "practitioner_role_html/*"

  @doc """
  Renders a practitioner_role form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def practitioner_role_form(assigns)
end
