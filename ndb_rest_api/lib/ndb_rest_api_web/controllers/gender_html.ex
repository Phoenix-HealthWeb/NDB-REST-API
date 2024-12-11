defmodule NdbRestApiWeb.GenderHTML do
  use NdbRestApiWeb, :html

  embed_templates "gender_html/*"

  @doc """
  Renders a gender form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def gender_form(assigns)
end
