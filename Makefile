run:
	nomad run manifests/traefik.hcl
	nomad run manifests/whoami.hcl

consul-dev:
	consul agent -dev -log-level INFO -config-file ./consul.hcl

# NB: dev-connect requires root privileges.
nomad-dev:
	sudo nomad agent -dev-connect -log-level INFO -config ./nomad.hcl
