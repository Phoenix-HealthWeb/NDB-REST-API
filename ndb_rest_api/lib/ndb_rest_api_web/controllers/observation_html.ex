defmodule NdbRestApiWeb.ObservationHTML do
  use NdbRestApiWeb, :html

  embed_templates "observation_html/*"

  @doc """
  Renders an observation form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :patients, :list, required: true
  attr :practitioners, :list, required: true
  attr :action, :string, required: true

  def observation_form(assigns)
end
