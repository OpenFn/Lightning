defmodule Lightning.Accounts.Policy do
  @behaviour Bodyguard.Policy

  alias Lightning.Accounts.User

  # Super users can do anything
  def authorize(_action, %User{role: :superuser}, _params), do: true

  # Regular users can't access user management page
  def authorize(action, %User{role: :user} = user, _params)
      when action in ~w[index]a,
      do: false

  # Default blacklist
  def authorize(_action, _user, _params), do: false
end