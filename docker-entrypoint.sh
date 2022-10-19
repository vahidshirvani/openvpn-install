#!/bin/bash
set -e
[ -z "$APPROVE_IP"          ] && export APPROVE_IP="y"
[ -z "$ENDPOINT"            ] && export ENDPOINT="127.0.0.1"
[ -z "$IPV6_SUPPORT"        ] && export IPV6_SUPPORT="n"
[ -z "$PORT_CHOICE"         ] && export PORT_CHOICE="2"
[ -z "$PORT"                ] && export PORT="1194"
[ -z "$PROTOCOL_CHOICE"     ] && export PROTOCOL_CHOICE="1"
[ -z "$DNS"                 ] && export DNS="3"
[ -z "$COMPRESSION_ENABLED" ] && export COMPRESSION_ENABLED="n"
[ -z "$CUSTOMIZE_ENC"       ] && export CUSTOMIZE_ENC="n"
[ -z "$CLIENT"              ] && export CLIENT="client001"
[ -z "$PASS"                ] && export PASS="1"
[ -z "$APPROVE_INSTALL"     ] && export APPROVE_INSTALL="y"
[ ! -f /etc/openvpn/server.conf ] && /bin/openvpn-install.sh
/etc/iptables/add-openvpn-rules.sh
exec /usr/sbin/openvpn --status /run/openvpn/server.status 10 --cd /etc/openvpn --script-security 0 --config /etc/openvpn/server.conf "$@"
