FROM archlinux
ADD docker-entrypoint.sh docker-entrypoint.sh
WORKDIR bin
RUN pacman --needed --noconfirm -Syu openvpn iptables openssl wget ca-certificates curl unbound \
    && curl -O https://raw.githubusercontent.com/angristan/openvpn-install/master/openvpn-install.sh \
    && chmod +x openvpn-install.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
