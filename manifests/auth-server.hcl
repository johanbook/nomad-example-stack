job "auth-server" {
  datacenters = ["dc1"]

  type = "service"

  group "server" {
    count = 1

    network {
      mode = "bridge"

      port "http" {
        to = 80
      }
    }

    service {
      name = "auth-server"
      port = "http"

      tags = [
        "traefik.enable=true",
        "traefik.http.routers.auth-server.rule=Path(`/login`)",
      ]

      connect {
        sidecar_service {
          proxy {
            upstreams {
              destination_name = "whoami-server"
              local_bind_port = 8034
            }
          }
        }
      }

      check {
        type     = "http"
        path     = "/"
        interval = "10s"
        timeout  = "2s"
      }
    }

    task "whoami" {
      driver = "docker"

      config {
        image = "auth:local"
        ports = ["http"]
      }

      env {
        WHOAMI_URL = "http://${NOMAD_UPSTREAM_ADDR_whoami_server}"
      }

    }
  }
}
