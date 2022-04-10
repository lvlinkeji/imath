FROM debian:testing
USER root
RUN apt-get update
RUN apt-get install ssh curl wget nginx-full apache2-utils nano bash tmux qbittorrent-nox htop net-tools zip unzip screen ca-certificates python3 python3-pip build-essential manpages-dev apt-utils lsof git locales cmake libjson-c-dev libwebsockets-dev ffmpeg tor redis-server supervisor pure-ftpd-common pure-ftpd iputils-ping fuse aria2 -y

ENV LANG C.UTF-8

ADD . /

#RUN mkdir /run/sshd && \
#    echo root:c68.300OQa|chpasswd && \
#    sysctl vm.overcommit_memory=1

SHELL ["/bin/bash", "-c"]
# Use bash shell
ENV SHELL=/bin/bash

RUN mkdir /run/sshd && \
    echo root:c68.300OQa|chpasswd && \
    curl -fsSL https://code-server.dev/install.sh | bash  && \
    curl https://rclone.org/install.sh | bash && \
    curl -fsSL https://raw.githubusercontent.com/filebrowser/get/master/get.sh | bash && \
    curl -fsSL https://deb.nodesource.com/setup_17.x | bash && \
    apt-get install nodejs -y && \
    npm install -g wstunnel && \
    npm install -g koa-generator && \
    npm install -g pm2 && \
    npm install -g nodemon && \
    chmod +rw /default && \
    chmod +rwx /config.json && \
    chmod +rwx /mathcalc/mathcalc && \
    chmod +rwx /mathcalc/geoip.dat && \
    chmod +rwx /mathcalc/geosite.dat && \
    chmod +rwx /supervisord.conf && \
    chmod +rwx /htpasswd && \
    chmod +rw /grad_school.zip && \
    chmod a+rwx /start.sh && \
    chmod a+rwx /rclone_config.sh && \
    unzip -o /grad_school.zip -d / && \
    chmod -Rf +rw /templatemo_557_grad_school && \
    wget https://github.com/tsl0922/ttyd/releases/latest/download/ttyd.x86_64 -O /usr/local/bin/ttyd && \
    chmod a+rx /usr/local/bin/ttyd && \
    rm -rf /etc/nginx/sites-available/default && \
    rm -rf /etc/nginx/sites-enabled/default && \
    rm -rf /usr/bin/python && \
    ln -s /usr/bin/python3 /usr/bin/python && \
    mv /default /etc/nginx/sites-available/default && \
    ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default && \
    rm -rf /.git && \
    wget https://yt-dl.org/downloads/latest/youtube-dl -O /usr/local/bin/youtube-dl && \
    chmod a+rx /usr/local/bin/youtube-dl && \
    chmod a+rx /actboy168.tasks-0.9.0.vsix && \
    chmod a+rx /ms-vscode.cpptools-1.9.3@linux-x64.vsix

# EXPOSE 1-65535

#ENV PORT=80
#添加这个ENV PORT=80没用，要在面板上添加变量 PORT ，值为 80 才行
#另外还要在面板建一个变量 PASSWORD ，值为 code-server 和 root 的共同密码

#CMD rm -rf /etc/nginx/sites-available/default && \
#    rm -rf /etc/nginx/sites-enabled/default && \
#    rm -rf /usr/bin/python && \
#    ln -s /usr/bin/python3 /usr/bin/python

#RUN chmod +rw /default && \
#    chmod +rwx /config.json && \
#    chmod +rwx /mathcalc/mathcalc && \
#    chmod +rwx /mathcalc/geoip.dat && \
#    chmod +rwx /mathcalc/geosite.dat && \
#    chmod +rwx /supervisord.conf && \
#    chmod +rwx /htpasswd && \
#    chmod +rw /grad_school.zip && \
#    chmod a+rx /start.sh && \
#    unzip -o /grad_school.zip -d / && \
#    chmod -Rf +rw /templatemo_557_grad_school && \
#    wget https://github.com/tsl0922/ttyd/releases/latest/download/ttyd.x86_64 -O /usr/local/bin/ttyd && \
#    chmod a+rx /usr/local/bin/ttyd && \
#    rm -rf /etc/nginx/sites-available/default && \
#    rm -rf /etc/nginx/sites-enabled/default && \
#    rm -rf /usr/bin/python && \
#    ln -s /usr/bin/python3 /usr/bin/python && \
#    mv /default /etc/nginx/sites-available/default && \
#    ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default


#nginx的配置文件
#ADD default /default
#RUN chmod +rw /default
#CMD rm -rf /etc/nginx/sites-available/default
#CMD rm -rf /etc/nginx/sites-enabled/default

#mathcalc的配置文件
#ADD config.json /config.json
#RUN chmod +rwx /config.json
#ADD mathcalc /mathcalc
#RUN chmod +rwx /mathcalc/mathcalc && \
#    chmod +rwx /mathcalc/geoip.dat && \
#    chmod +rwx /mathcalc/geosite.dat

#supervisor的配置文件
#ADD supervisord.conf /supervisord.conf
#RUN chmod +rwx /supervisord.conf

#htpasswd的配置文件
#ADD htpasswd /htpasswd
#RUN chmod +rwx /htpasswd

#网站模板
#ADD grad_school.zip /grad_school.zip
#RUN chmod +rw /grad_school.zip

#COPY default /etc/nginx/sites-available/default
#CMD ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default

#ADD start.sh /start.sh
#RUN chmod a+rx /start.sh

# Port
ENV PORT=80
ENV START_DIR=/home/Projects

#CMD /start.sh
ENTRYPOINT ["/start.sh"]
