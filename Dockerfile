FROM docker.io/library/fedora:44@sha256:6c75d5bf57cb0fa5aa4b92c6a83c86c791644496d9ac230de7711f5b8ec3b898

LABEL maintainer="Project Potos"

ENV container="docker"
ENV pip_packages="ansible"

RUN echo "max_parallel_downloads=20" >> /etc/dnf/dnf.conf

# hadolint ignore=DL3041
RUN dnf -y update && dnf clean all

# Enable systemd.
# hadolint ignore=DL3041,DL3003
RUN dnf -y install systemd && dnf clean all && \
  (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ "$i" = systemd-tmpfiles-setup.service ] || rm -f "$i"; done) && \
  rm -f /lib/systemd/system/multi-user.target.wants/* && \
  rm -f /etc/systemd/system/*.wants/* && \
  rm -f /lib/systemd/system/local-fs.target.wants/* && \
  rm -f /lib/systemd/system/sockets.target.wants/*udev* && \
  rm -f /lib/systemd/system/sockets.target.wants/*initctl* && \
  rm -f /lib/systemd/system/basic.target.wants/* && \
  rm -f /lib/systemd/system/anaconda.target.wants/*

# Install uv and other requirements.
# hadolint ignore=DL3041
RUN dnf -y install \
  uv \
  sudo \
  which \
  python3-rpm \
  python3-libdnf5 \
  && dnf clean all

# Install Ansible via uv.
RUN uv pip install $pip_packages --system

# Disable requiretty.
RUN sed -i -e 's/^\(Defaults\s*requiretty\)/#--- \1/' /etc/sudoers

# Install Ansible inventory file.
RUN mkdir -p /etc/ansible && \
  printf '[local]\nlocalhost ansible_connection=local\n' > /etc/ansible/hosts

VOLUME ["/sys/fs/cgroup", "/tmp", "/run"]
CMD ["/usr/sbin/init"]
