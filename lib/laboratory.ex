#defmodule Laboratory do
  #use Application

  ## See http://elixir-lang.org/docs/stable/elixir/Application.html
  ## for more information on OTP Applications
  #def start(_type, _args) do
    #import Supervisor.Spec

    ## Define workers and child supervisors to be supervised
    #children = [
      ## Start the endpoint when the application starts
      #supervisor(Laboratory.Endpoint, []),
      ## Start your own worker by calling: Laboratory.Worker.start_link(arg1, arg2, arg3)
      ## worker(Laboratory.Worker, [arg1, arg2, arg3]),
    #]

    ## See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    ## for other strategies and supported options
    #opts = [strategy: :one_for_one, name: Laboratory.Supervisor]
    #Supervisor.start_link(children, opts)
  #end

  ## Tell Phoenix to update the endpoint configuration
  ## whenever the application is updated.
  #def config_change(changed, _new, removed) do
    #Laboratory.Endpoint.config_change(changed, removed)
    #:ok
  #end

  #def enabled?(conn, feature) when is_atom(feature) do
    #conn.cookies[to_string(feature)] == "true"
  #end
#end
defmodule Laboratory do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
       worker(__MODULE__, [], function: :start_server),
    ]

    opts = [strategy: :one_for_one, name: Laboratory.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def start_server do
    { :ok, _ } = Plug.Adapters.Cowboy.http Laboratory.DevPlug, []
  end

  def enabled?(conn, id) do
    conn = fetch_cookies(conn)
    conn.cookies[to_string(id)] == "true"
  end
end
