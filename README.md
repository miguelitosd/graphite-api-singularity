graphite-api-singularity
========================

After upgrading to ubuntu 24.04LTS I found that while the rest of the pre-existing graphite bits were available:
* carbon-cache
* graphite-web

etc, but there's no updated build for graphite-api.  Even the pip installed version would run for me, but 
threw errors and trying to us it as a data source for grafana threw errors.  I have some historical data
I didn't want to lose however, so I really wanted to get graphite working.

I spent a little time on graphite-web again, but it seems like such overkill, so I gave running graphite-api inside
a container a shot.  Using docker on ubuntu now is a snap based install which seemed to also cause some issues, 
like you can't write to any data paths outside /home by default. So since we use singularity at work and find
that it's a great solution for basically wrapping an app in a container that's basically the older distro libraries 
and such, I figured it was worth a try.  It was actually pretty quick and simple to get it working as desired.

# To install/use:
Packages needed to run as-is:
* singularity-container
* tmux

# Prep:
Possibly edit the paths or timezone in the def file or shell script. Also you could change the tmux logic to screen
or create an actual systemd unit file to run as a service if desired. Current config assumes whisper data is in 
/var/lib/graphite/whisper and that we'll just bind it directly into the container as well as us subdirs index for the index
file and logs for stderr/out files.

# Build/run the container:
```
$ sudo singularity build graphite-api.sif graphite-api.def
$ ./start-graphite-api.sh
```

# Tmux
I used tmux to run the container like a daemon but as a user, and you can check for it using 
`tmux ls`
to see if the screen shows up, to connect
`tmux at -t graphite-api`

Files:
* .gitignore 
    * Ignore the built/binary .sif file once there
* graphite-api.def
    * Configuration for singularity to build the container
* start-graphite-api.sh
    * Simply shell script to start up the container, possibly change path names if needed or bind paths.
