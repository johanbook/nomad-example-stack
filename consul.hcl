# Consul Connect is by default enabled in dev mode but disabled
# in production.
connect {
  enabled = true
}

# Needed for Consul Connect in production.
ports {
  grpc = 8502
}
