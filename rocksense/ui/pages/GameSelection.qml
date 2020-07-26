import QtQuick 2.2
import QtQuick.Controls 2.2 //Page
import "../items/."
import "../fonts/."


Page {
    id: menu
    title: qsTr("Gameauswahl")
    width: 600
    height: 924

    FontLoader { id: mollen; source: "../fonts/MollenRegular.otf" }
    FontLoader { id: scratch; source: "../fonts/Scratch.otf" }


    Background {
        id: background

        // buttons to the different games
        Column {
            id: columnMenu
            spacing: 75
            width: 600
            anchors.horizontalCenter: parent.horizontalCenter

            Description {
                text: "Bei Get Them All geht es darum alle leuchtenden Griffe so schnell wie möglich zu berühren. \nAber Achtung: Die Zeit läuft!"
            }


            // button to the get them all game
            Rectangle {
                id: getThemAllButton
                width: 400
                height: 100
                color: "#3a4055"

                anchors.topMargin: 200
                anchors.horizontalCenter: parent.horizontalCenter

                Text {
                    id: getThemAllText
                    height: 36
                    text: "Get Them All"
                    color: "white"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    font.bold: true
                    font.family: scratch.name
                    font.pixelSize: 50
                }

                MouseArea {
                    id: getThemAllMouse
                    anchors.fill: parent
                    onClicked: {
                        gamemanager.set_chosen_game(0) // sets get them all as chosen game
                        stack.push("GTAStartPage.qml")
                    }
                }
            }


            Description {
                text: "Bei Catch It geht es darum so viele aufleuchtende Griffe wie möglich zu berühren - Du hast eine Minute Zeit!"
            }

            // button to the catch it game
            Rectangle {
                id: catchItButton
                width: 400
                height: 100
                color: "#3a4055"
                //anchors.top: usertext.bottom
                anchors.topMargin: 200
                anchors.horizontalCenter: parent.horizontalCenter

                Text {
                    id: catchItText
                    text: "Catch It"
                    color: "white"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    font.bold: true
                    font.family: scratch.name
                    font.pixelSize: 50
                }

                MouseArea {
                    id: catchItMouse
                    anchors.fill: parent
                    onClicked: {
                        gamemanager.set_chosen_game(1) // sets catch it as chosen game
                        stack.push("CatchItStartPage.qml")
                    }
                }
            }
        }
    }
}

