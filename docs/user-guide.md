# User Guide
![Getting Started](../img/start.jpg){: style="height:300px;width:300px"}

## Einrichtung der Wand

Die verwendete Wand kann beliebige Maße haben. Diese werden später im Programm angegeben.
**Wichtig ist folgendes**:

1. Jeder Griff muss mit einem LED und einem Sensor verbunden sein.
2. Für die LEDs wurde ein Neopixel-Strip verwendet. Dieser wurde über den GPIO Pin 18 mit dem Raspberry Pi verbunden. Der Strip muss außerdem mit einem 5V Pin und einem GND Pin verbunden werden.
4. Die Eingänge der Sensoren werden in Multiplexern, sog. *Port Expandern*, gebündelt. Über jeden Port Expander (PE) können die Signale von 16 Sensoren eingelesen werden. Jedem Expander und jedem Sensor wird dafür eine individuelle Adresse gegeben. Die PE werden über den VDD (Pin 9 des PE) mit einer Eingangsspannung (5V) versorgt und über den VSS (Pin 10 des PE) wird an GND angeschlossen. A0, A1 und A2 des PE werden an + (3.3V) bzw. – (GND) angeschlossen und legen intern die Adresse des Port Expanders fest. Jeder PE wird dann über den SCL (Pin 12 des PE) an den GPIO Pin 5 des Raspberry Pis und über den SDA (Pin 13 des PE) an den GPIO Pin 3 des Raspberry Pis angeschlossen. Die Adresse des ersten PE ist 0x20 mit A0, A1 und A2 auf GND, die Adresse des zweiten PE ist 0x21 mit A0 auf 3.3V und A1 und A2 jeweils auf GND und so weiter.
5. Die Schaltung sollte etwa so aussehen:

![Abbildung Schaltung](../img/schaltung.png){: style="height:300px;width:300px"}

## Einrichtung des Raspberry Pis

1. Auf dem Pi muss die RockSense Anwendung installiert sein.
2. Für das Auslesen der Port Expander muss in der Raspberry Pi Konfiguration unter *Advanced Options* die Configuration *I2C* aktiviert sein. Die Raspberry Pi Konfiguration ruft man unter ```sudo raspi-config``` auf.

####Installationsbefehle
Folgende Installationsbefehle müssen ausgeführt werden um alle nötigen Packages zu installieren.

#####Timer Games
*Func Timeout* (Timer für die Spiele):
```sh
sudo pip3 install func_timeout
```
#####GUI
*PySide2* (für die Integration der grafischen Oberfläche):
```sh
sudo apt-get install python3-pyside2.qt3dcore python3-pyside2.qt3dinput python3-pyside2.qt3dlogic python3-pyside2.qt3drender python3-pyside2.qtcharts python3-pyside2.qtconcurrent python3-pyside2.qtcore python3-pyside2.qtgui python3-pyside2.qthelp python3-pyside2.qtlocation python3-pyside2.qtmultimedia python3-pyside2.qtmultimediawidgets python3-pyside2.qtnetwork python3-pyside2.qtopengl python3-pyside2.qtpositioning python3-pyside2.qtprintsupport python3-pyside2.qtqml python3-pyside2.qtquick python3-pyside2.qtquickwidgets python3-pyside2.qtscript python3-pyside2.qtscripttools python3-pyside2.qtsensors python3-pyside2.qtsql python3-pyside2.qtsvg python3-pyside2.qttest python3-pyside2.qttexttospeech python3-pyside2.qtuitools python3-pyside2.qtwebchannel python3-pyside2.qtwebsockets python3-pyside2.qtwidgets python3-pyside2.qtx11extras python3-pyside2.qtxml python3-pyside2.qtxmlpatterns python3-pyside2uic

```
<br>
#####LEDs und Sensoren
*Adafruit Blinka* (für die Steuerung der LEDs und Sensoren):
```sh
sudo pip3 install adafruit-blinka
```
<br>
*Adafruit Neopixel* (für die Steuerung des LED Strips):
```sh
sudo pip3 install adafruit-circuitpython-neopixel
```
<br>
*Adafruit MCP23017* (für die Port Expander):
```sh
sudo pip3 install adafruit-circuitpython-mcp230xx
```
<br>
#####Touchscreen
*Rotation*
```sh
sudo nano /boot/config.txt
```
Änderung:  ```display_rotate=3 # Rotation des Bildschirms um 270 Grad```

Im Menü:
*Einstellungen*<br>
*Screen Configuration*<br>
*Configure* --> *Screens* --> *HDMI-1* --> *Drehung* --> **left**
<br>

*Kalibrierung*
```sh
cd /usr/share/X11/xorg.conf.d
```
```sh
sudo touch 99-calibration.conf
```
```sh
sudo apt-get install xinput-calibrator
```
Im Menü:
*Einstellungen*<br>
*Touchscreen Kalibrieren* --> den Anweisungen folgen<br>
**Die entstehende Datei kopieren und in das 99-calibration.conf-File einfügen.**<br>
**In die vorletzte Zeile ```Option "TransformationMatrix" "0 -1 1 1 0 0 0 0 1"``` schreiben.**
<br>
Neustart, um die Änderungen zu übernehmen.
```sh
sudo reboot
```
<br>
*Matchbox Keyboard*
```sh
sudo apt-get install matchbox-keyboard
```
<br>
*Mauszeiger ausblenden*
```sh
sudo apt-get install unclutter 
```
<br>
####Autostart des Programms
Nun muss das Programm noch in den Autostart des Raspberry Pis übernommen werden. 
Dafür ruft man über die Konsole den Editor für Cronjobs auf: 
```sh
sudo crontab -e
```
Es sollte sich eine Datei im Editor öffnen, in der man den neuen Cronjob am Ende einfügen kann:
```sh
@reboot sudo python3 /home/pi/RockSense/main.py
```
Mit "Strg - X" beenden und mit "J" bestätigen.
