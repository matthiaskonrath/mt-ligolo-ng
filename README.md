# MT-ligolo-ng
Ligolo-ng for Mikrotik RouterOS (arm / arm64)

![ligolo-ng Mikrotik Screenshot](https://github.com/matthiaskonrath/mt-ligolo-ng/blob/main/Screenshot%202025-12-13%20at%2021.50.45.png)
![ligolo-ng Proxy - Terminal](https://github.com/matthiaskonrath/mt-ligolo-ng/blob/main/Screenshot%202025-12-13%20at%2021.51.54.png)
![ligolo-ng Proxy - Web UI](https://github.com/matthiaskonrath/mt-ligolo-ng/blob/main/Screenshot%202025-12-13%20at%2021.55.46.png)


### Build and export the package (arm / arm64) by chaning the settings in `build.sh` and running it
```
nano build.sh
./build.sh
```

### Setup the network
```
/interface/veth/add name=veth1 address=172.17.0.2/24 gateway=172.17.0.1
/interface/bridge/add name=containers
/ip/address/add address=172.17.0.1/24 interface=containers
/interface/bridge/port add bridge=containers interface=veth1
```

### Add firewall and NAT rules
```
/ip/firewall/filter/add src-address=172.17.0.0/24 dst-address=0.0.0.0/0 chain=forward  action=accept
/ip/firewall/nat/add chain=srcnat action=masquerade src-address=172.17.0.0/24
```

### Import the uploaded container
```
/container/add file=mt-ligolo-ng_arm64.tar interface=veth1 logging=yes
```

### ligolo-ng configuration and start (see logs for results)
To ignore the certificate just add `-ignore-cert`
```
/container/set cmd="-connect TARGET_IP:PORT" mt-ligolo-ng_arm64 start-on-boot=yes
/container/start mt-ligolo-ng_arm64
```

Relevant links:
- https://help.mikrotik.com/docs/display/ROS/Container
- https://docs.docker.com/build/building/multi-platform/
- https://github.com/nicocha30/ligolo-ng
