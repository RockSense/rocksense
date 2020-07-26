# Game Klasse, Gamemanager und Score Klasse

## Konstruktor

```python
def __init__(self, game_id: str, game_name: str, hold_list: list, timer: float)
```

Ein Spiel hat immer eine eindeutige ID, einen Namen, eine Liste von Griffen, die für dieses Spiel aktiv sein sollen und eine Zeit, die bestimmt wie lange ein Spiel gespielt wird. Ist diese Zeit 0, läuft kein Timer rückwärts, sondern die Zeit wird gestoppt.


###Instanzparameter:
```
game_id # eindeutig identifizierbare Game-ID
```
```
game_name # Name des Spiels
```
```
hold_list # Liste aller für das Spiel benötigten Griffe
```
```
timer # Maximale Länge des Spiels in Sekunden
```

#Klasse Gamemanager
## Klassenvariablen
```python
chosen_game: Game = None # speichert das ausgewählte Spiel
```
```python
games_list: list = [] # speichert eine Liste aller existierenden Spiele
```
```python
active_user: User = usermanager.current_user # speichert den aktiven User, der im Usermanager ausgewählt wurde
```
```python
scores_list: list = [] # speichert die erreichten Zeiten oder Punkte
```
```python
score_count: int = 0 # zählt die erreichten Punkte in CatchIt
```
```python
current_game_scores: list = [] # Liste der Scores des aktuellen Spiels
```
```python
isFinished = Signal() # Signal, dass an QML gesendet wird, wenn eine Methode beendet ist
```
```python
current_score = 0 # speichert die erreichte Zeit in GetThemAll
```


##Methoden
#### Spielkonfigurationen laden
```python
def load_xml_games()
```
Liest Konfigurationsdaten aus einer XML-Datei ein. Transformiert die, in Integern angegebenen, benötigten Wandzonen in die entsprechenden Griffe und speichert diese in einer Liste. Anschließend wird mit Hilfe des ``Game``-Konstruktors ein neues Spiel-Objekt erstellt und der ``games_list`` angehängt.


#### Ergebnisse laden
```python
def load_xml_scores(gamename)
```
Nimmt den Namen des ausgewählten Spiels entgegen und liest die dazu bereits vorhandene Ergebnisse ein und speichert sie in der ``scores_list``. Ist noch keine Ergebnisdatei vorhanden wird bei Speicherung ein neues erstellt.


#### Spiele sichern
```python
def save_games()
```
Es wird eine XML-Struktur mit den Spieldaten erzeugt und in eine Datei gespeichert.


#### Ergebnisse sichern
```python
def save_scores(gamename)
```
Nimmt den Namen des ausgewählten Spiels entgegen, kreiert eine XMl-Struktur und lädt die dazugehörigen Ergebnisse in eine XML-Datei.


### Setzen des aktuellen Spiels
```python
def set_chosen_game(self, index)
```
Setzt die Klassenvariable ``chosen_game`` auf das in der Benutzeroberfläche ausgewählte Spiel.


### Starten des Spiels 'GetThemAll'
```python
def start_getthemall(self)
```
Startet einen Thread in dem das Spiel GetThemAll gestartet wird, der im Hintergrund zu einem Countdown in der Benutzeroberfläche läuft.


### Starten des Spiels 'CatchIt'
```python
def start_catchit(self)
```
Startet einen Thread in dem das Spiel CatchIt gestartet wird, der im Hintergrund zu einem Timer in der Benutzeröberfläche läuft.


### Übergeben des aktuellen GetThemAll-Scores
```python
def show_current_score(self)
```
Übergibt den aktuellen Spielstand zur weiteren Nutzung in der Benutzeroberfläche. 


### Übergeben des aktuellen CatchIt-Punktestands 
```python
def show_score_count(self):
```
Übergibt den aktuellen Punktestand zur weiteren Nutzung in der Benutzeroberfläche.


### Übergeben des gesetzten Timers für CatchIt
```python
def set_timer
```
Übergibt den in der XML-Datei gesetzten Timer für das Spiel CatchIt.


#### Spiellogik Spiel1 Get Them All
```python
def get_them_all()
```
Legt fest, dass ein Drittel der Griffe jeder verwendeten Zone aktiviert wird. Anschließend werden der Listener für die Sensoren und die Stoppuhr gestartet. Dann wird solange überprüft ob noch Griffe unberührt sind bis alle einmal berührt wurden. Ist das der Fall, wird ein Signal an die Benutzeroberfläche gesendet und die Zeit gestoppt. Sobald das Spiel beendet ist, wird das Ergebnis als neues ``Score``-Objekt gespeichert und zu der Liste der Scores hinzugefügt.


### Spiellogik Spiel2 CatchIt
```python
def catch_it_logic()
```
Wählt einen randomisierten Griff aus den für das Spiel verfügbaren Griffen aus und lässt ihn aufleuchten. Wird er berührt, erhöht sich der ``score_count`` um Eins. Anschließend wird er ausgeschaltet und erneut ein randomisierter Griff gewählt. Dies wiederholt sich solange, bis der in der XML-Datei definierte Timer abgelaufen ist. Ziel ist es, so viele Griffe wie möglich in der angegebenen Zeit zu erreichen.

### Spielablauf Spiel2 CatchIt
```python
def catch_it()
```
Sorgt dafür, dass das Spiel zum Ablauf des Timers sofort beendet wird und legt die erreichte Punktzahl als Score Objekt an. Anschließend werden die Scores direkt in eine XML-Datei gespeichert.


### Übergeben bestimmter 
```python
def score(self, rank: int, game: int)
```
Ordnet die Scores aus der ``scores_list`` den Spielen zu und übergibt den angefragten Score an die Benutzeroberfläche.


# Klasse Score

## Konstruktor
```python
def __init__(self, currentlyclimbing_id, user_id, user_score, timestamp)
```
###Instanzparameter
```python
self.currentlyclimbing_id #ID des Spiels oder der Route die gerade geklettert wird
```
```python
self.user_id = user_id # ID des Users der den Score erzielt hat
```
```python
self.user_score = user_score # Ergebnis des Spiels
```
```python
self.timestamp = timestamp # Zeitstempel Jahr, Monat, Tag & Zeit zu der der Score erreicht wurde
```