# User und Usermanager
##User-Klasse

### Konstruktor

```python
def __init__(self, firstname: str, lastname: str, id_number: int = None)
```

Falls eine ID durch Importieren der User mitgegeben wird, wird diese ID verwendet. Im anderen Fall, dass ein neuer User angelegt wird, wird die nächste freie ID verwendet, indem die aktuelle Userzahl abgefragt wird.
Mit Verwenden des Konstruktors wird außerdem der Wert der ```user_count```-Variable um eins inkrementiert und der angelegte User der ```user_list```-Liste angehängt.


####Klassenvariablen:
```python
user_count: int = 0  # aktuelle Anzahl von User-Instanzen
``` 
####Instanzparameter:
```
firstname # Vorname des Users
``` 
```
id_number # eindeutig identifierbare User-ID
```


### Methoden
#### __init__
```python
def __init__(self, firstname: str, id_number: int = None)
```
Mit Initialisieren des Users wird ein User-Objekt angelegt. Enweder bekommt der User die mitgegebene User-ID oder erhält mit der ``get_next_id()`` eine nächst freie ID.


####  überschriebene String-Methode
```python
def __str__(self)
```
Es wird der Vorname und die ID einer ```User``` Instanz ausgegeben.


#### User hinzufügen
```python
def add_user(firstname, lastname)
```
Mit der Mitgabe von Vornamen wird eine neue Instanz eines Users angelegt. Intern wird der Konstruktor der ``User``-Klasse aufgerufe. Dem Konstruktor werden die Funktionsvariablen und der Return-Wert der Methode ``get_next_id()`` mitgegeben. Es wird der neu angelegte User zurückgegeben.


#### nächste User-ID erhalten
```python
def get_next_id()
```
Als Rückgabe erhält man die nächste verfügbare ID. Der Zähler ``user_count`` wird außerdem inkrementiert.


##Usermanager
### Globale Variablen
```python
user_string_list = []   # Liste, um alle Usernamen zu speichern
``` 
```python
user_list: list = []   # Liste, um alle Instanzen von Usern zu speichern
``` 
```python
current_user: User = None   # speichert den aktuellen User
``` 
```python
model = QStringListModel()	# speichert und erstellt dass QStringListModel zur Useranzeige in QML
``` 
###Methoden
#### Slot: User erstellen
```python
def set_username(self, user_name):
```
Ruft die ``add_user(user_name)``-Methode auf und erstellt ein User-Objekt. Außerdem wird der User der ``user_string_list`` hinzugefügt. Mit Erstellen wird der User ebenso zum ``current_user`` gespeichert. Die aktuellen User werden ins XML-File gespeichert. Der User wird dem StringListModel zur Anzeige in QML hinzugefügt.

####Slot: Current User setzen
```python
def set_current_user(self, index):
```
Setzt den ``current_user`` aufgrund des mitgebenen Listenindex aus dem QML ListModel.

####Slot: Current User anzeigen
```python
def show_current_user_name(self):
```
Der Username des aktuellen Users wird zurückgegeben. Dies wird unter anderem in der Begrüßung des Users im QML verwendet.

####StringListModel erstellen
```python
def set_string_list_model(model):
```
Übergibt alle die ``user_string_list`` dem ``QStringListModel`` und gibt das Model zur ANzeige in QML zurück.

#### User laden
```python
def load_users()
```
Diese Methode liest Userdaten aus einer XML-Datei ein. Die XML muss in der Funktion definiert werden. Jeder eingelesene User wird mithilfe des ``User``-Konstruktors erstellt und der ``user_list`` angehängt. Falls hier Fehler auftreten, werden sie abgefangen.


#### User sichern
```python
def save_users()
```
Eine XML-Struktur mit den Userdaten wird erzeugt und in eine vorher bestimmte XML-Datei geschrieben.

####  alle User anzeigen
```python
def show_users()
```
Die Methode gibt die aktuelle Useranzahl im System wieder. Im Anschluss werden alle Userdaten ausgegeben.
