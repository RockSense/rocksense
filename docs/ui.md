# UI

Für die UI von RockSense wurden mithilfe des Qt Creators mehrere QML-Files (Qt Modeling Language) erstellt. 
Diese stellen die einzelnen Seiten oder Komponenten der Anwendung dar.

## Nötige Imports
```
import QtQuick 2.2 
```
```
import QtQuick.Controls 2.2 //Page
```
Je nach Seite werden Dateien aus anderen Ordnern benötigt, die in diesem Schema importiert werden:
```
import "../items/."
```
## Ordnerstruktur
Neben der main.qml gibt es den Ordner Pages, der alle qml-Files enthält, den Ordner Items, der alle selbst erstellten qml-Items enthält, den Ordner Fonts, der die importierten Schriftarten enthält und den Ordner Images, der die Icons und verwendeten Bilder enthält.

## main.pyproject
Diese Datei enthält alle verwendeten files mit dem entsprechenden Path, hier verkürzt darrgestellt:

```
{
"files": ["main.py",
"pages/StartPage.qml",
"main.qml"
 ]
}
```

## main.qml und StackView 

Die main.qml ist mit dem ApplicationWindow die Hauptseite der UI. 
Von dort werden die einzelnen Pages mit einer StackView aufgerufen, die untereinander verlinkt werden. Als Window-Größe wird hier die Breite und Höhe festgelegt, sowie die Sichtbarkeit im Bildschirm auf "Fullscreen" gesetzt.

### StackView

Die StackView mit der id stack wurde im ApplicationWindow für die Navigation Control erstellt. Die stack.depth gibt dabei die Anzahl der Pages an, die auf den Stack gepushed wurden.

```
StackView {
    id: stack
    initialItem: StartAnimation {}
}
```
Mit dieser id und der push( ) Methode der StackView können auf allen Seiten Verlinkungen zur nächsten Seite gesetzt werden. 
```
stack.push("pages/UserSelection.qml")
```

### BorderImage

Das BorderImage ist die Menüleiste auf den folgenden Seiten und wird durch die Stack-Tiefe gesteuert. Nur auf der ersten Seite gibt es keine Menüleiste.

```
opacity: stack.depth > 1 ? 1 : 0
```
Darin wurden einzelne Buttons eingebaut, die jederzeit zugänglich sind: Ein Zurück-Button führt auf die jeweils vorherige Seite durch die Methode pop( ).

```
onClicked: stack.pop()
```
Außerdem führt ein User-Button zur Userauswahl und ein Settings-Button zu den Grundeinstellungen der Anwendung.

## Erklärung der Pages von RockSense

-  StartAnimation: Hier wird eine Animation beim Start gezeigt.
-  UserSelection: Die UserSelection zeigt eine Liste aller erstellten User und gibt die Möglichkeit neue User anzulegen.
- Welcome: Der ausgewählte User wird begrüßt.
-  MenuSelection: Games, Routen oder Highscores können hier ausgewählt werden.
-  RouteSelection: Die zu kletternde Route kann  aus einer Liste ausgewählt werden, die auf einem Routen Model basiert. Außerdem kann eine neue Route angelegt werden.
-  GameSelection: Die GameSelection zeigt eine Liste aller erstellten Routen und gibt die Möglichkeit neue Routen anzulegen.
-  GeneralSettings: Grundeinstellungen wie die Wandauswahl, Userauswahl und das Beenden der Anwendung können hier festgelegt werden.
-  NewUser/NewRoute: Hier können neue User oder Routen angelegt werden.
-  Highscore: Hier werden die Bestenlisten der gekletterten Routen und Games angezeigt.
-  Timer: Der Timer zeigt einen Countdown an und anschließend während des Spiels "Catch It" den ablaufenden Timer. Nach Ablauf des Timers wird eine "Der Timer ist abgelaufen" 
-  Countdown: Diese Seite lässt einen Countdown ablaufen und startet anschließend die Stopuhr. Es gibt einmal den GameCountdown für das Spiel Get Them All und den RouteCountdown für alle Routen.
- StartPage/EndResult: Auf dieser Seite können Routen bzw. Games gestartet werden. Es gibt die GTAStartPage für das Spiel Get Them All, die RouteStartPage für die Routen und CatchItStartPage für das Spiel Catch It. Jeweils gibt es entsprechenede Endergebnis-Seiten.

## Wichtige UI-Elemente

### Layout Elemente
-  Row positioniert untergeordnete Elemente nebeneinander an
-  Column positioniert untergeordnete Elemente untereinander an
-  Rectangle bildet ein Rechteck, das wiederum mehrere Elemente enthalten kann

### Eigene Elemente
-  Description ist eine Vorlage um eine Textbeschreibung auf einer Page anzuzeigen
-  Footer ist eine Vorlage für eine Element am Ende der Page.
-  Background ist ein Hintergrund, der in jeder Page einfach eingefügt werden kann.

### Page
Eine normale Page besteht zunächst aus dem Root-Element Page. Darin werden alle Elemente so angeordnet, dass die gewünschte Konstellation angezeigt werden kann.


### Mouse Area
Die Mouse Area gibt einen Bereich vor, das den Touch oder Klick eines Users erkennt und daraufhin beispielsweise auf die nächste Seite leitet.

```
MouseArea {
    anchors.fill: parent
    onClicked: stack.push("pages/UserSelection.qml")
}
```
### FontLoader
Der FontLoader lädt eine Schriftart auf einer Page.

```
FontLoader { id: mollen; source: "../fonts/MollenRegular.otf" }

```
Über die Methode name( ) und die ID der Schriftart können bei Textelementen dann die einzelnen Schriftarten gesetzt werden.
```
font.family: mollen.name

```
### ListView
Die ListView zeigt eine Liste von Elementen an basierend auf einem Model. Dabei werden die einzelnen Elemente von der ListView delegiert.

### Timer
Der Timer lässt eine Zeit ablaufend basierend auf einem Intervall. Bei einem Signal steuert Signal Handler onTriggered die daraufhin folgenden Angaben.

```
Timer {
    id: timerGame
    interval: 1000 // one second
    running: false // start is required
    repeat: true
    onTriggered:
        if (minute == 0 && second == 0) { // time is up
            running = false
            countdown = -2
        }
        else if (second == 0 ) {
            minute-=1
            second = 59
        }
        else {
            second-=1
        }

}
```

