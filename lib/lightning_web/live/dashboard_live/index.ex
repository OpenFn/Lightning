defmodule LightningWeb.DashboardLive.Index do
  @moduledoc false
  use LightningWeb, :live_view
  alias Lightning.Projects

  on_mount {LightningWeb.Hooks, :project_scope}

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket |> assign(active_menu_item: :projects)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply,
     apply_action(
       socket,
       socket.assigns.live_action,
       params
     )}
  end

  defp apply_action(socket, :index, _params) do
    project = Projects.first_project_for_user(socket.assigns.current_user)

    if project != nil do
      socket
      |> push_redirect(
        to: Routes.project_dashboard_index_path(socket, :show, project.id)
      )
    else
      socket
      |> assign(:page_title, "Projects")
      |> assign(active_menu_item: :projects)
      |> assign(:projects, nil)
    end
  end

  defp apply_action(socket, :show, %{"project_id" => project_id} = params) do
    socket
    |> assign(
      project: Projects.get_project(project_id),
      active_menu_item: :overview,
      selected_id: params["selected"]
    )
    |> assign(:page_title, socket.assigns.project.name)
  end
end
