#!/bin/bash
PS3='Debian Server Setup Scripts: '
choice=("Setup Sudo" "Install Docker" "Exit")
select opt in "${choice[@]}"; do
    case $opt in
        "Setup Sudo")
            echo "Setting up sudo"
            apt update
            apt install sudo -yy
            user=$(getent passwd 1000 |  awk -F: '{ print $1}')
            echo "$user  ALL=(ALL:ALL)  ALL" >> /etc/sudoers
            echo "Sudo setup complete."
            ;;
        "Install Docker")
            echo "Installing Docker"
            curl -fsSL https://get.docker.com -o get-docker.sh
            sudo sh get-docker.sh
            COMPOSE_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep 'tag_name' | cut -d\" -f4)
            sudo curl -L https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
            sudo chmod +x /usr/local/bin/docker-compose
            sudo curl -L https://raw.githubusercontent.com/docker/compose/${COMPOSE_VERSION}/contrib/completion/bash/docker-compose > /etc/bash_completion.d/docker-compose
            user=$(getent passwd 1000 |  awk -F: '{ print $1}')
            sudo usermod -aG docker $USER
            echo "Docker setup complete. Please log out & log back in after exiting to use without sudo."
            ;;
	"Exit")
	    echo "Exiting"
	    exit
	    ;;
        *) echo "invalid option $REPLY";;
    esac
done