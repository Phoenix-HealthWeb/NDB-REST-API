defmodule NdbRestApiWeb.ObservationHTML do
  use NdbRestApiWeb, :html

  embed_templates "observation_html/*"

  @doc """
  Renders a observation form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def observation_form(assigns)
end
