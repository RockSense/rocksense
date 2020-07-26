#Route Klasse und Routemanager

#Klasse Route
##Konstruktor
```python
def __init__(self, route_id, route_name, hold_list, start_hold, end_hold):
```

###Instanzparameter
```python
route_id # eindeutige Identifikation der Route
```
```python
route_name # Name der Route
```
```python
hold_list # Liste mit Griffen, die für die Route benötigt werden
```
```python
start_hold # Griff, mit dem die Route gestartet wird
```
```python
end_hold # Griff, mit dem die Route beendet wird
```

#Klasse Routemanager
## Klassenvariablen
```python
routes_list: list = []  # Liste von Routen
```
```python
current_route: Route = None  # aktuell ausgewählte Route
```
```python
current_route_name: str = ""  # Name der aktuell ausgewählten Route
```
```python
scores_list: list = []  # Liste der Kletterzeiten
```
```python
routes_string_list: list = []  # Liste der Routennamen
```
```python
chosen_holds_int = []  # Liste der IDs der Griffe der ausgewählten Route
```
```python
new_route_name = ""  # Name der neu angelegten Route
```
```python
routelistmodel = QStringListModel()  # Liste der Namen aller Routen für die Benutzeroberfläche
```
```python
isFinished = Signal() # Signal, dass an die Benutzeroberfläche gesendet wird, wenn eine Methode beendet ist
```
```python
isStarted = Signal()  # Signal, dass an die Benutzeroberfläche gesendet wird, wenn eine Methode gestartet wird.
```
```python
current_climbing_time = 0 # speichert die benötigte Kletterzeit
```
## Methoden
#### Routen laden
```python
def load_xml_routes():
```
Lädt ggf. bereits existierende Routen aus einer XML-Datei, transformiert die in Form von Integern angegebenen Griffnummern in Griff-Objekte, hinterlegt Start- und Endgriff und speichert pro Route eine entsprechende Griffliste. 
Alle Routen werden in einer ``routes_list`` gespeichert. Falls Fehler auftreten, wird eine IO-Exception geworfen.


#### Zeiten/Ergebnisse laden
```python
def load_xml_times():
```
Lädt ggf. bereits existierende Kletterzeiten aus einer XML-Datei und speichert sie in der ``scores_list``. Falls Fehler auftreten, wird eine IO-Exception geworfen.


#### Routen speichern
```python
def save_routes():
```
Es wird eine XML-Struktur mit den Routendaten erzeugt und in eine XML-Datei geschrieben. Die Griffe werden anhand ihrer IDs gespeichert. Außerdem wird der Start- und der Endgriff jeder Route als Integer gespeichert (entspricht der entsprechenden Griff ID).


#### Zeiten/Ergebnisse laden
```python
def save_times():
```
Es wird eine XML-Struktur mit den Kletterzeiten erzeugt und in eine XML-Datei geschrieben. Dabei wird die Kletterzeit pro Route und User mit einem Zeitstempel gespeichert.


#### Routenname festlegen
```python
@Slot(str)
def set_route_name(self, route_name)
```
Legt den Routennamen für eine neue Route fest (``new_route_name``) und speichert ihn in der ``routes_string_list``.


#### Routenname anzeigen
```python
@Slot(result=str)
def show_route_name(self)
```
Zeigt den Routennamen einer Route an zur Übergabe an die Benutzeroberfläche.

#### Routennamen in Liste hinzufügen
```python
def routes_to_string_list(self)
```
Die Namen aller Routen werden in die ``routes_string_list`` geschrieben, um sie in der Benutzeroberfläche anzuzeigen.

#### Routennamen als Liste anzeigen
```python
def set_stringlistmodel(model)
```
Erstellt ein Modell für die Benutzeroberfläche, welche die Anzeige als der Routen als Liste ermöglicht.


#### Aktuelle Route festlegen
```python
@Slot(str)
def set_current_route(self, index)
```
Legt die aktuelle Route anhand des übergebenen Index und dem entsprechenden Eintrag in der ``routes_string_list`` fest. Dabei werden auch der entsprechende Start- und Endgriff definiert. Zum Schluss wird die Route angezeigt (die entsprechenden Griffe der Wand leuchten).

#### Griff zur Route hinzufügen
```python
@Slot(int)
def add_to_hold_list(self, index)
```
Möchte der Nutzer eine eigene Route anlegen, wird entsprechend dem auf der Benutzeroberfläche ausgewählten Griff mithilfe eines übergegeben Index ein Eintrag der ``chosen_holds_int``-Liste hinzugefügt.

#### Griff von der Route entfernen
```python
@Slot(int)
def remove_from_hold_list(self, index)
```
Gegenfunktion zur ``add_to_hold_list``-Funktion. Hier kann der Nutzer in der Benutzeroberfläche ausgewählte Griffe wieder abwählen. Entsprechend wird der Eintrag in der ``chosen_holds_int``-Liste entfernt.

#### Route hinzufügen
```python
@Slot()
def add_new_route(self)
```
Die erstellte Route wird der ``routes_list`` hinzugefügt. Dafür wird eine ``chosen_holds``-Liste anhand der ``chosen_holds_int``-Liste erstellt und die Start- und Endgriffe der Route anhand der Reihenfolge der Auswahl der Griffe in der Benutzeroberfläche festgelegt.

#### Route anzeigen
```python
def show_route(route: Route)
```
Zeigt die aktuelle Route (``current_route``), also die, welche durch den Nutzer im Menü ausgewählt wurde, an der Wand an. Der Startgriff ist dabei grün beleuchtet und der Endgriff rot.

#### Route starten (Thread)
```python
@Slot()
def start_route(self)
```
Startet einen Thread für das Klettern der Route. Parallel kann so die Stopuhr der Benutzeroberfläche laufen.

#### Route starten
```python
@Slot(result=str)
def start_climbing_route(self)
```
Der Nutzer klettert die Route. Zuerst wird der Listener für die benötigten Griffe gestartet. Sobald am Startgriff eine Berührung registriert wurde, wird die Stopuhr gestartet. Bei jedem Griff, den der Nutzer verwendet, wird die LED ausgeschaltet. Berührt der Nutzer schließlich den Endgriff der Route, wird die Stopuhr beendet und alle LEDs (potentiell übersprungener Griffe) ausgeschaltet. Darüberhinaus wird die benötigte Kletterzeit in der ``current_climbing_time`` gespeichert. Die Kletterzeit wird zur ``scores_list`` hinzugefügt und alle Scores in einer XML-Datei gespeichert.

#### Kletterzeit anzeigen
```python
@Slot(result=str)
def show_current_climbing_time(self)
```
Die Methode übergibt die benötigte Kletterzeit an die Benutzeroberfläche, um sie dem Nutzer anzuzeigen.