# Wall Klasse und Wallmanager

## Konstruktoren
###Wall
```python
def __init__(self, width: int, height: int, zone_edge: int, title: str, wall_id: int)
```
Beim Anlegen einer Wand muss die Höhe der Wand ```height``` und die Breite der Wand ```width``` angeben werden. Damit ist jeweils die Anzahl der vertikalen und horizontalen Griffe gemeint. Eine Höhe von 20 heißt also, dass es 20 Griffreihen gibt. Eine Breite von 12 heißt es gibt 12 Griffspalten.

Um die Wand in verschiedene Zonen einzuteilen, welche z.B. bei den Spielen verwendet werden, muss außerdem die "Kantenlänge" einer Zone ```zone_edge``` angeben werden. Eine Kantenlänge von 3 heißt, dass eine Zone dieser Wand aus einem Quadrat von 5 x 5 = 25 Griffen besteht.

Zur Veranschaulichung:

![Wall Schema](../img/schema.png){: style="height:300px;width:300px"}

Jedes X steht für einen Griff. Die roten Zahlen sind die Zonen.

Zuletzt muss ein Titel für die Wand und eine ID mitgegeben werden.

###Wallmanager
```python
def __init__(self)
```
Beim Anlegen eines Wallmanagers wird eine Standardwand geladen, welche aber mit der ```set_current_wall()```-Methode noch geändert werden kann. Diese Methode wird aufgerufen, wenn der Nutzer in den Einstellungen eine andere Wand auswählt.

## Methoden
#### set_current_wall
```python
def set_current_wall(self, index)
```
Ändert die Wand, wenn der Nutzer in den Einstellungen eine andere Wand auswählt. Bisher ist eine Prototyp-Wand (```index``` = 0) und eine Standard-Wand (```index```` = 1) hinterlegt.

#### config_wall
```python
def config_wall(wall: Wall)
```
Die Funktion konfiguriert eine Wand anhand der mitgegebenen Parameter (Höhe, Breite, Kantenlänge). Sie legt die Griffe an und gibt ihnen jeweils ihre ID, ihre Position und ihre Zone mit. Diese Zone ist wichtig, um später die hinterlegten Spiele zu spielen.
Mit dem Anlegen eines Griffes werden auch direkt die entsprechende LED und der entsprechende Sensor angelegt. Für das Anlegen der Sensoren wird die Adresse des jeweiligen Port Expander benötigt. Es können immer 16 Sensoren über den selben Expander abgehört werden, dann wird auf die nächste PE-Adresse zugegriffen.

#### start_listener
```python
def start_listener(hold_list: List[Hold]):
```
Die Methode startet den *Listener*, also den entsprechenden Thread aus der Hold-Klasse als Daemon-Thread für alle Griffe in der übergebenen Liste, d.h. Berührungen an diesen Griffen werden jetzt registriert. Der Listener endet, wenn eine Berührung an einem Griff registriert wurde.

#### report_hold
```python
def report_hold(hold: Hold)
```
Mit dieser Funktion wird zurückgegeben, ob und wie oft ein bestimmter Griff benutzt wurde.

#### reset
```python
def reset(hold_list: List[Hold])
```
Mit dieser Funktion werden alle Griffe der übergebenen Liste zurückgesetzt (also die Berührungen werden gelöscht), um eine neue Route klettern oder ein neues Spiel spielen zu können.

#### startshow
```python
def startshow()
```
Diese Funktion ermöglicht eine Art "Lightshow" beim Beginn des Programms. Dies stellt sowohl eine Funktionskontrolle aller LEDs dar, als auch eine Begrüßung des Nutzers. Es kann zwischen drei Animationen gewählt werden: ColorSwipe, RainbowCycle und TheaterChaseRainbow.

#### startshow thread
```python
def start_startshow(self)
```
Die Startshow-Funktion wird so als Thread aufgerufen, sodass der Nutzer während der "Lightshow", bereits Eingaben in der Anwendung machen kann. Diese Funktion wird über die Startseite beim Berühren des Bildschirms aufgerufen.

#### shutdown_leds
```python
def shutdown_leds(self):
```
Diese Funktion schaltet alle LEDs der aktuell genutzten Wand aus.