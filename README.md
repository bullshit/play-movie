play-movie
======

Download file deb package from https://github.com/bullshit/play-movie/releases
install it with ```dpkg -i FILENAME.deb```

after that add a cronjob with ```crontab -e``` 
and add something like

```0/5 * * * * /opt/play-movie/cronjob.sh```
this will start the cronjob every 5 minute

now add a autostart
add following to /etc/rc.local
```nohup /opt/play-movie/playback.sh &```
