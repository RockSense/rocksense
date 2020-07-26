# Hold Klasse

## Konstruktor

```python
def __init__(self, hold_id: int, x: int, y: int, mcp)
```

Beim Konfigurieren einer Boulder Wall in der ```config_wall```- Methode des Wallmanagers werden entsprechend der angebenen Abmessungen der Wand Griffe ("Holds") angelegt. Die Griffe haben eine Position mit ```x```-Koordinate und ```y```-Koordinate. Außerdem werden die Griffe durchnummeriert und bekommen eine eindeutige ID ```hold_id```. Jedem Griff muss außerdem die Adresse des Port Expanders für den zugehörigen Sensor mitgegeben werden (```mcp```).<br>
Beim Anlegen eines Griffs werden ihm außerdem eine LED und ein Sensor zugewiesen:
```python
led = Led(hold_id)
```
```python
sensor = Sensor(hold_id, mcp)
```

Ebenso bekommt jeder Hold in der ```config_wall```- Methode eine ```zone``` zugewiesen.


Die Parameter ```touched```, ```start``` und ```end``` werden per Default auf ```False``` gesetzt.

## Methoden
#### listener
```python
def listener(self)
```
Diese Funktion startet den Listener. Solange der Griff nicht berührt wurde, wird alle 10 ms geprüft, ob der Griff berührt wurde. Wird ein Griff berührt, wird die Berührung in den Buffer des Port Expander geschrieben. Dieser Wert wird durch den Listener ausgelesen.
Registriert der Listener eine Berührung, wird ```touched``` auf ```True``` gesetzt.