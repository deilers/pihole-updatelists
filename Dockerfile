FROM pihole/pihole:latest

COPY install.sh pihole-updatelists.* /tmp/pihole-updatelists/

COPY .bash_aliases .

RUN apt-get update && \
    apt-get upgrade -Vy && \
    apt-get install -Vy php-cli php-sqlite3 php-intl php-curl nano htop && \
    apt-get clean && \
    rm -fr /var/cache/apt/* /var/lib/apt/lists/*.lz4

RUN source .bash_aliases

RUN chmod +x /tmp/pihole-updatelists/install.sh && \
    bash /tmp/pihole-updatelists/install.sh && \
    rm -fr /tmp/pihole-updatelists
