FROM fedora
ADD docker-entrypoint.sh docker-entrypoint.sh
WORKDIR bin
RUN dnf install -y openvpn iptables openssl wget ca-certificates curl policycoreutils-python-utils unbound \
    && curl -O https://raw.githubusercontent.com/angristan/openvpn-install/master/openvpn-install.sh \
    && chmod +x openvpn-install.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
