# Synology NAS: Run Samba in Docker container to provide network shares for MS-DOS (MS Client 2.0)
Based on ServerContainers/samba, see https://github.com/ServerContainers/samba for how to configure in detail.


1. Build docker image

```
cd SambaCC
docker build -t samba_classic  .
docker save samba_classic -o samba_classic.tar
```

https://github.com/ServerContainers/samba


2. Setup virtual network addresses in Synology's host lan

In this example the LAN has 192.168.77.0/24 and Synology NAS is 192.168.77.130.
For the docker container running on the NAS we reserve a subnet.
192.168.77.132/29 -> 192.168.77.137 - 192.168.77.142 255.255.255.248
First docker container gets 192.168.77.136.
192.168.77.120 is the internet router.

Logon to the NAS via SSH and run the following command:

```
sudo docker network create --driver=macvlan --gateway=192.168.77.120 \
	--subnet=192.168.77.0/24  --ip-range=192.168.77.136/29 \
	-o parent=eth0 localnetwork
```


3. Import docker image to Synology NAS

DSM -> Docker -> Image -> Hinzufügen -> Aus Datei hinzufügen (Upload samba_classic.tar from step 1)


4. Adjust configuration in SambaCC.json

Map user id to existin NAS user.
Create has of user password.
Configure a share.

https://github.com/ServerContainers/samba


5. Create container based on SambaCC.json

DSM -> Container -> Einstellungen -> Importieren (Upload SambaCC.json)
Select Container -> Aktion -> Start

Connect to your share e.g. \\SambaCC\CC or \\192.168.77.136\CC.

