play-movie
======

Die Installationsdatei finden sie unter https://github.com/bullshit/play-movie/releases

# Abhänigkeiten installieren
als root (oder mit sudo )

```
apt-get install python-configobj
```

# Play-movie installieren

```
dpkg -i FILENAME.deb
```

# Konfiguration

## Download Zeitinterval einstellen

Als root user einfach mit 
```crontab -e``` 
die Cronjob Datei laden und folgendes eintragen

```*/5 * * * * /opt/play-movie/cronjob.sh```

Dies startet die Überprüfung im Interval von 5 Minuten ob eine neue Datei vorhanden ist für den Download vorhanden ist.

## Konfigurationsdatei

Unter ```/etc/default/play-movie```

Hier können Sie folgende Dinge einstellen

### Download Pfad
```
DOWNLOAD_PATH="/opt/tmp"
```

### Pfad zur Videodatei
```
VIDEO_URL="http://austria24.tv/download/aktuell.mp4"
```

### Dateiendung
```
VIDEO_EXT=".mp4"
```
Dies muss mit der VIDEO_URL einstellung übereinstimmen

### Dateiname
```
VIDEO_FILENAME="aktuell${VIDEO_EXT}"
```
Dies muss mit der VIDEO_URL Einstellung übereinstimmen. Die Konfiguration $(VIDEO_EXT} bitte beibehalten.


### Videoplayer Einstellungen
```
OMX_PLAYER_ARGS="-r -o hdmi"
```
"-o hdmi" bedeutet das die Videoausgabe über HDMI durchgeführt werden sollen
"-r" Der Videoplayer übernimmt die aktuelle Bildschirmauflösung

### Email Benachrichtung
```
SEND_MAIL="1"
```
Wenn "SEND_MAIL" den Wert 1 hat wird wenn sich die Datei unter VIDEO_URL aktualisiert hat eine Benachrichtung per mail verschickt

#### Email Versand Einstellungen (SMTP)
```
MAIL_HOST="smtp.gmail.com"
```
```
MAIL_PORT="587"
```
```
MAIL_USER="hd02t005@gmail.com"
```
```
MAIL_PASS="xxxxxxx"
```
```
MAIL_FROM="$MAIL_USER"
```
```
MAIL_TO="me@oskarholowaty.com"
```

#### Betreff 
```
MAIL_SUBJECT="Host: #HOST# download notification"
```
Bitte beachten Sie die Zeichenkette "#HOST#" diese wird mit dem Rechnernamen ersetzt.
#### Email Nachricht

```
MAIL_BODY="File successfull downloaded."
```
MAIL_BODY ist die eigentliche Emailnachricht

# Protokoll

Der Downloader protokoliert alles in die datei /var/log/playmovie_cronjob.log. 
Der play-movied service protokolliert in die Datei /var/log/playmovied.log

Diese Datei wird wöchentlich kompromiert und für ein monat vorbehalten. 
Dies kann in der Datei ```/etc/logrotate.d/playmovie``` geändert werden.

# Abspielen in einer Dauerschleife
Während der installation wird ein "Dienst" konfiguriert der mit "service play-movied start" gestartet werden kann.
Dies passiert auch bei einem Neustart voll automatisch. (Vorsicht nach der installation ist der Dienst noch nicht gestartet). Hier wird auch die neu herunter geladene Datei "neu geladen".

# Lautstärke
Es wurde ein vol script integriert (/usr/bin/vol). Mittels diesem Skript wird die Lautstärke auf 95% eingestellt. (Siehe /etc/rc.local)





(c) Oskar Holowaty
