import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :frontend_challenge, FrontendChallengeWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "S5Sv3cYiFtgPTXWxkA3A+gKIp/YmRvGwWXl34RQ5J6i6kZvIwDLs/lcCnIX8/dwu",
  server: false

# In test we don't send emails.
config :frontend_challenge, FrontendChallenge.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
