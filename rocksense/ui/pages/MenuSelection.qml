import QtQuick 2.2
import QtQuick.Controls 2.2 //Page
import "../items/."
import "../pages/."
import "../fonts/."



Page {
    id: menu
    title: qsTr("Menü")
    width: 600
    height: 924

    FontLoader { id: mollen; source: "../fonts/MollenRegular.otf" }
    FontLoader { id: scratch; source: "../fonts/Scratch.otf" }

    Background {

        // all buttons für routes, games and highscore
        Column {
            id: columnMenu
            spacing: 75
            width: 600
            anchors.horizontalCenter: parent.horizontalCenter

            Description {
                text: "Möchtest du dich an verschiedenen Routen ausprobieren oder sogar selbst eine Route erstellen?"
            }

            Rectangle {
                id: routeButton
                width: 400
                height: 100
                color: "#3a4055"
                //anchors.top: usertext.bottom
                anchors.topMargin: 200
                anchors.horizontalCenter: parent.horizontalCenter

                Text {
                    id: routeButtonText
                    y: 26
                    height: 36
                    text: "Routen"
                    color: "white"
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.bold: true
                    font.family: scratch.name
                    font.pixelSize: 50
                }

                MouseArea {
                    id: routeButtonMouse
                    anchors.fill: parent
                    onClicked: stack.push("RouteSelection.qml") //leads to the route selection
                }

            }


            Description {
                text: "Möchtest du coole Spiele ausprobieren?"
            }

            Rectangle {
                id: gameButton
                width: 400
                height: 100
                color: "#3a4055"
                //anchors.top: usertext.bottom
                anchors.topMargin: 200
                anchors.horizontalCenter: parent.horizontalCenter

                Text {
                    id: gamesText
                    text: "Games"
                    color: "white"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    font.bold: true
                    font.family: scratch.name
                    font.pixelSize: 50
                }

                MouseArea {
                    id: gameMouse
                    anchors.fill: parent
                    onClicked: stack.push("GameSelection.qml") //leads to the game selection
                }

            }


            Description {
                text: "Möchtest du die Bestenliste anschauen?"
            }

            Rectangle {
                id: highscoreButton
                width: 400
                height: 100
                color: "#3a4055"
                //anchors.top: usertext.bottom
                anchors.topMargin: 200
                anchors.horizontalCenter: parent.horizontalCenter

                Text {
                    id: highscoreButtonText
                    text: "Bestenliste"
                    color: "white"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    font.bold: true
                    font.family: scratch.name
                    font.pixelSize: 50
                }

                MouseArea {
                    id: mouse3
                    anchors.fill: parent
                    onClicked: stack.push("Highscore.qml") //leads to the highscores
                }
            }
        }
    }
}

