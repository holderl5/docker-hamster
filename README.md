# docker-hamster
run hamster time tracker in docker in newer versions of ubuntu

This is a work in progress, currently, it just works and that is good enough for now.  Feel free to submit improvements.  I have only been using it for one day and so far have not hit any showstoppers

BACKGROUND
To install hamster-time-tracking in 18.04 I followed some instructions I found somewhere.  I did my best to verify the MD5s of the included DEB packages were correct. 

On 19.04, I didn't even want to mess with trying to install.  I wanted a one stop shop going forward.  

I found these instructions and modified them:
http://fabiorehm.com/blog/2014/09/11/running-gui-apps-with-docker/

**WARNING:**
I DID NOT INCLUDE A BLANK hamster.db - for whatever reason running it here without that causes it to crash instead of creating a hamster.db  

**SETUP**
- Install docker (I am currently using 19.03)
- Clone the repo
- Provide a hamster.db
- docker build -t hamster . 
- docker volume create hamsterdb

I use the following shell script to launch for my personal user:
```
#!/bin/bash
sudo docker run -ti --rm \
       -e DISPLAY=$DISPLAY \
       -v /tmp/.X11-unix:/tmp/.X11-unix \
       -v hamsterdb:/home/developer/.local/share/hamster-applet \
        hamster
```
The docker volume will reside in your volumes directory where you can back it up if you like.  On linux that is normally /var/lib/docker/volumes
