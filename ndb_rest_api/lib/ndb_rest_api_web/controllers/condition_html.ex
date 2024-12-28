defmodule NdbRestApiWeb.ConditionHTML do
  use NdbRestApiWeb, :html

  embed_templates "condition_html/*"

  @doc """
  Renders a condition form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :patients, :list, required: true
  attr :practitioners, :list, required: true
  attr :action, :string, required: true

  def condition_form(assigns)
end
