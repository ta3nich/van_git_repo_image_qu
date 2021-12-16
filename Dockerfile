
FROM registry.gitlab.com/keyzer0xkeyzer0x/allppine_t1


ENV container docker
ENV LC_ALL C
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
    && apt-get install -y systemd systemd-sysv \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN rm -f /lib/systemd/system/multi-user.target.wants/* \
    /etc/systemd/system/*.wants/* \
    /lib/systemd/system/local-fs.target.wants/* \
    /lib/systemd/system/sockets.target.wants/*udev* \
    /lib/systemd/system/sockets.target.wants/*initctl* \
    /lib/systemd/system/sysinit.target.wants/systemd-tmpfiles-setup* \
    /lib/systemd/system/systemd-update-utmp*



ENV _IMG_USERNAME=headless _IMG_PASSWORD=admin

ENV DISPLAY=:1 \
    VNC_PORT=5901 \
    NO_VNC_PORT=6080 \
    SSH_PORT=22 \
    SUPER_VISOR__PORT=9001 \
    DEBIAN_FRONTEND=noninteractive
###########################################################################
ENV HOME=/root \
    TERM=xterm \
    STARTUPDIR=/dockerstartup \
    INST_SCRIPTS=/root/install \
    ADD_SCRIPTS=/root/install_add \
    NO_VNC_HOME=/usr/share/novnc \
    DEBIAN_FRONTEND=noninteractive \
    VNC_COL_DEPTH=24 \
    VNC_RESOLUTION=1360x768 \
    VNC_PW=vncpassword \
    VNC_VIEW_ONLY=false
### Envrionment config


###########################################################################


################################## ADD FILES ##################################

COPY ./src/startup.sh "${STARTUPDIR}"/
COPY ./src/go_go.sh "${STARTUPDIR}"/

COPY ./src/ddncd.conf /etc/supervisor/conf.d/


ADD ./src/ $INST_SCRIPTS/

RUN find $INST_SCRIPTS -name '*.sh' -exec chmod a+x {} +
RUN find "${STARTUPDIR}"/ -name '*.sh' -exec chmod a+x {} +
################## Envrionment config ##########################################
WORKDIR $HOME
RUN $INST_SCRIPTS/package4.sh

#######################  SSH ###########################################

###########################################################################

############################ ADD ROOT PASSWORD ###########################


#########################################################################





RUN cp $INST_SCRIPTS/vncserver@.service /etc/systemd/system/vncserver.service
RUN cp $INST_SCRIPTS/supervisor.service /etc/systemd/system/supervisor.service
#################################################################################
RUN update-rc.d supervisor enable
#RUN update-rc.d vncserver enable
#####################################
EXPOSE $VNC_PORT $NO_VNC_PORT $SSH_PORT $SUPER_VISOR__PORT










CMD ["/lib/systemd/systemd"]

