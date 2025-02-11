FROM ubuntu:noble

# --- environment setup with user home, display for vnc and nginx port
ARG USER=ubuntu
ENV DEBIAN_FRONTEND=noninteractive \
    PACKER_LOG=1 \
    PACKER_LOG_PATH="/dev/stdout"
EXPOSE 8080
EXPOSE 9090


# --- install packages
RUN apt-get update &&\
    apt-get --no-install-recommends --yes install \
        curl wget gnupg lsb-release ca-certificates &&\
        wget -qO - https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp.gpg &&\
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" > /etc/apt/sources.list.d/hashicorp.list &&\
    apt-get update &&\
    apt-get --no-install-recommends --yes install \
        git git-lfs make jq psmisc \
        ovmf swtpm procps genisoimage qemu-utils qemu-user qemu-system qemu-system-x86 qemu-system-arm packer cloud-init \
        websockify novnc supervisor nginx &&\
    apt-get clean autoclean &&\
    apt-get --yes autoremove --purge &&\
    rm -rf /var/lib/apt/lists/*


# --- setup data with user home directory and vnc
COPY ./rootfs /
RUN chown -R ${USER}:${USER} /var/lib/nginx
WORKDIR /src


# --- start supervisore daemon to start nginx and vnc
CMD ["/usr/bin/supervisord", "-s", "-j", "/var/run/supervisord.pid", "-l", "/dev/null", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
