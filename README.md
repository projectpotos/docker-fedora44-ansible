# Fedora 44 Ansible Test Image

[![docker-publish](https://github.com/projectpotos/docker-fedora44-ansible/actions/workflows/docker-publish.yml/badge.svg)](https://github.com/projectpotos/docker-fedora44-ansible/actions/workflows/docker-publish.yml) [![lint](https://github.com/projectpotos/docker-fedora44-ansible/actions/workflows/lint.yml/badge.svg)](https://github.com/projectpotos/docker-fedora44-ansible/actions/workflows/lint.yml)

Fedora 44 Docker container for Ansible playbook and role testing.

Images are published to the GitHub Container Registry (GHCR) at
`ghcr.io/projectpotos/docker-fedora44-ansible`.

## Tags

  - `latest`: Latest stable version of Ansible.

The latest tag is a lightweight image for basic validation of Ansible playbooks.

## How to Build

This image is built and published automatically on every push to `main` and
weekly so it keeps up with upstream Fedora updates. To build it locally:

  1. [Install Docker](https://docs.docker.com/engine/installation/).
  2. `cd` into this directory.
  3. Run `docker build -t fedora44-ansible .`
