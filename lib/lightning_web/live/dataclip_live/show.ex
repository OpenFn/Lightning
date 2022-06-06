defmodule LightningWeb.DataclipLive.Show do
  @moduledoc """
  LiveView for viewing a single dataclip
  """
  use LightningWeb, :live_view

  alias Lightning.Invocation

  on_mount {LightningWeb.Hooks, :project_scope}

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, "Show Dataclip")
     |> assign(:active_menu_item, :dataclips)
     |> assign(:dataclip, Invocation.get_dataclip!(id))}
  end
end