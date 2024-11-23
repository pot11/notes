# 安装软件

## Jellyfin

Install Jellyfin On Armbian Android TV Box
Log into Armbian
Run the following commands in terminal

```shell
sudo apt install apt-transport-https
wget -O - https://repo.jellyfin.org/jellyfin_team.gpg.key | sudo apt-key add -
echo "deb [arch=$( dpkg --print-architecture )] https://repo.jellyfin.org/$( awk -F'=' '/^ID=/{ print $NF }' /etc/os-release ) $( awk -F'=' '/^VERSION_CODENAME=/{ print $NF }' /etc/os-release ) main" | sudo tee /etc/apt/sources.list.d/jellyfin.list
sudo apt update
sudo apt install jellyfin
```

Open a web browser and navigate to http://DNSorIP:8096  
Follow the setup wizard
Welcome to Jellyfin  
