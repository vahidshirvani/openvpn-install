# openvpn-install
Run the popular [angristan/openvpn-install](https://github.com/angristan/openvpn-install) script in Docker container.
* Source available at Github: [https://github.com/vahidshirvani/openvpn-install](https://github.com/vahidshirvani/openvpn-install)
* Image available at Docker hub: [https://hub.docker.com/r/vahidshirvani/openvpn-install](https://hub.docker.com/r/vahidshirvani/openvpn-install)

## Build
In case you want to build the image yourself then 
```bash
docker build -t vahidshirvani/openvpn-install:latest .
```

## Run
Spin up openvpn with the command
```bash
IP=$(curl ifconfig.me)
docker run                                             \
    --name openvpn                                     \
    --volume $HOME/.openvpn/etc/openvpn:/etc/openvpn   \
    --volume $HOME/.openvpn/etc/unbound:/etc/unbound   \
    --volume $HOME/.openvpn/etc/iptables:/etc/iptables \
    --volume $HOME/.openvpn/root:/root                 \
    --restart unless-stopped                           \
    --cap-add=NET_ADMIN                                \
    --device=/dev/net/tun                              \
    --detach                                           \
    --publish 1194:1194/udp                            \
    --env PORT="1194"                                  \
    --env PROTOCOL_CHOICE="1"                          \
    --env ENDPOINT="$IP"                               \
    vahidshirvani/openvpn-install:latest
```
Note: `PROTOCOL_CHOICE=1` maps to UDP while TCP is `2`. 

## Add clients
For generating new clients run the command 
```bash
docker exec -it openvpn bash -c "openvpn-install.sh"
```
You can find the `*.ovpn` file at location `$HOME/.openvpn/root`

## Remove
Stop openvpn and cleanup stored files from disk.
```bash
docker stop openvpn
docker rm openvpn
rm -rf $HOME/.openvpn
docker system prune --all --force
```

## Troubleshooting
* Make sure you have configured port-forwarding in your NAT router.
* Is openvpn running? `docker ps -a`
* look at the logs with `docker logs openvpn`
