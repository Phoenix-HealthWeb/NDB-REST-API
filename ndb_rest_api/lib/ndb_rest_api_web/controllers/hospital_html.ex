defmodule NdbRestApiWeb.HospitalHTML do
  use NdbRestApiWeb, :html

  embed_templates "hospital_html/*"

  @doc """
  Renders a hospital form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true
  attr :practitioners, :list, required: true

  def hospital_form(assigns)
end
