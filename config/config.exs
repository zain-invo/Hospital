# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :hospital,
  ecto_repos: [Hospital.Repo]

# Configures the endpoint
config :hospital, HospitalWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "KspdHOYG9uX+LHSKhxZxJhMJ1ibp0bcZOzvg7uQBJ9vavce/Q+izArD+jodhcNML",
  render_errors: [view: HospitalWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Hospital.PubSub,
  live_view: [signing_salt: "R+DnJt4X"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

config :ueberauth, Ueberauth,
       providers:
  [   github: {Ueberauth.Strategy.Github, [default_scope: "user,public_repo,notifications"]}  ]
config :ueberauth, Ueberauth.Strategy.Github.OAuth,
  client_id: "55c66f9c753144689aa8",
  client_secret: "775567e93bdeac8d128dbbcd75b2358c2f8821af"
