# LED Klasse

## Konstruktor

```python
def __init__(self, led_id: int)
```
Jede LED bekommt eine ID zugewiesen. Diese entspricht der ID ihres Griffes und wird bei der Konfiguration der Boulder Wand generiert.
Die LEDs sind durchnummierte NeoPixel LEDs, welche jeweils über ihre ID einzeln ansprechbar sind.
Es wird außerdem eine Farbliste angelegt, welche Farbnamen (red, orange, yellow, green, lightblue, blue, violet, pink, magenta, white) in RGB-Code übersetzt.

## Methoden
#### led_on
```python
def led_on(self, color: str)
```
Diese Funktion beleuchtet eine bestimmte LED in einer bestimmten Farbe. Die Farbe wird als String übergeben und dann entsprechend der obigen Farbliste in einen RGB-Code übersetzt. Sie wird über eine einzelne LED aufgerufen. Beispiel: ```led.led_on("red")```.

#### change_color
```python
def change_color(self)
```
Diese Funktion wechselt die Farbe einer bestimmten LED in eine zufällige andere Farbe.

#### led_off
```python
def led_off(self)
```
Diese Funktionen schaltet eine bestimmte LED aus. Sie wird ebenfalls über eine einzelne LED aufgerufen. Beispiel: ```led.led_off()```

#### all_led_off
```python
def all_led_off()
```
Diese Funktionen schaltet alle LEDs aus. Sie wird über die Klasse aufgerufen.
<br><br>
Die Folgenden Funktionen werden für die ```startshow()``` Funktion des Wallmanagers benötigt. Sie stellen unterschiedliche Animationen des LED-Strips dar.

#### wheel
```python
def wheel() # Wheel Animation über alle LEDs
```
#### rainbowCycle
```python
def rainbow_cycle(wait) # Regenbogen Animation über alle LEDs, wait: Delay pro Schritt, z.B. 1ms = 0.001
```
#### colorWipe
```python
def colorWipe(color,wait) # Wisch Animation über alle LEDs in einer bestimmten Farbe "red", "green", "blue", "white"), wait: Delay pro Schritt, z.B. 1ms = 0.001
```
#### theaterChaseRainbow
```python
def theaterChaseRainbow(wait) # Theater-Chase Animation über alle LEDs, wait: Delay pro Schritt, z.B. 1ms = 0.001
```