FROM ubuntu:18.04

RUN apt-get update && apt-get install -y libwnck22 libwnck-common  python-gtk2
COPY python-wnck_2.32.0+dfsg-3_amd64.deb /tmp/
RUN dpkg -i /tmp/python-wnck_2.32.0+dfsg-3_amd64.deb
RUN apt -y install python-gconf python-gnome2 libbonoboui2-0 libgnomecanvas2-0 libgnomeui-0 python-pyorbit libglade2-0 libbonoboui2-common libgnomecanvas2-common libgnome-keyring0 libgnomeui-common liborbit2 libgnome-keyring-common libidl-2-0 python-dbus python-xdg
COPY hamster-applet_2.91.3+git20120514.b9fec3e1-1ubuntu2_all.deb /tmp/
RUN dpkg -i /tmp/hamster-applet_2.91.3+git20120514.b9fec3e1-1ubuntu2_all.deb
RUN apt -y install libcanberra-gtk-module sudo

RUN apt-get install -y tzdata
RUN ln -fs /usr/share/zoneinfo/America/Chicago /etc/localtime
RUN dpkg-reconfigure --frontend noninteractive tzdata
# I run scripts to push my time automatically to intervals, and need certs.  Yes this made another layer :(
RUN apt-get install ca-certificates
# Replace 1000 with your user / group id
RUN export uid=1000 gid=1000 && \
    mkdir -p /home/developer && \
    echo "developer:x:${uid}:${gid}:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:${uid}:" >> /etc/group && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
    chmod 0440 /etc/sudoers.d/developer && \
    chown ${uid}:${gid} -R /home/developer
VOLUME /home/developer/.local/share/hamster-applet/
COPY hamster.db /home/developer/.local/share/hamster-applet/
RUN chown 1000:1000 /home/developer/.local/share/hamster-applet/hamster.db
RUN chown 1000:1000 /home/developer/.local/share/hamster-applet/
RUN chmod 664 /home/developer/.local/share/hamster-applet/
USER developer
ENV HOME /home/developer
CMD /usr/bin/hamster-time-tracker
#CMD /bin/bash

