# DebianServer-Setup

Simple shell script for setting up a Debian server. Options to install Sudo, Docker-Compose, and setup UFW quickly.

```bash
su

apt-get install curl

curl https://raw.githubusercontent.com/merlins-lair/DebianServer-Setup/refs/heads/main/server.sh -o server.sh

chmod +x server.sh

./server.sh
```