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

    FontLoader { id: scratch; source: "../fonts/Scratch.otf" }
    FontLoader { id: mollen; source: "../fonts/MollenRegular.otf" }


    Background {}

    // button to change the user
    Rectangle {
        id: userChange
        width: parent.width
        height: 100
        color: "#3a4055"
        anchors.top: parent.top
        anchors.topMargin: 60
        anchors.horizontalCenter: parent.horizontalCenter

        Text {
            id: textUser
            height: 36
            text: "User wechseln"
            font.family: scratch.name
            color: "white"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            font.bold: false
            font.pixelSize: 35
        }

        MouseArea {
            id: mouseUser
            anchors.topMargin: 0
            anchors.fill: parent
            onClicked: stack.push("UserSelection.qml")
        }

    }

    // button to change the wall
    Rectangle {
        id: wallChange
        width: parent.width
        height: 100
        color: "#3a4055"
        anchors.top: userChange.bottom
        anchors.topMargin: 80
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter

        Text {
            id: textWall
            height: 36
            text: "Wand wechseln"
            color: "white"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            font.bold: false
            font.family: scratch.name
            font.pixelSize: 35
        }

        MouseArea {
            id: mouseWall
            anchors.fill: parent
            onClicked: stack.push("WallSelection.qml")
        }
    }

    // button to end the application for users
    Rectangle {
        id: endButton
        width: parent.width
        height: 100
        color: "#3a4055"
        anchors.top: wallChange.bottom
        anchors.topMargin: 80
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter

        Text {
            id: textEnd
            height: 36
            text: "Beenden"
            color: "white"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            font.bold: false
            font.pixelSize: 35
            font.family: scratch.name
        }

        MouseArea {
            id: mouseEnd
            anchors.fill: parent
            onClicked: popupExit.open() // opens popup window
        }

    }

    // button to end the application for admin
    Rectangle {
        id: exitExit
        width: parent.width
        height: 100
        color: "#3a4055"
        anchors.top: endButton.bottom
        anchors.topMargin: 80
        anchors.horizontalCenter: parent.horizontalCenter

        Text {
            id: exitText
            height: 36
            text: "Complete Exit"
            color: "white"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            font.bold: false
            font.pixelSize: 35
            font.family: scratch.name
        }

        MouseArea {
            id: mouseExit
            anchors.topMargin: 0
            anchors.fill: parent
            onClicked: {
                wallmanager.shutdown_leds()
                Qt.quit()
            }
        }
    }

    // popup window to confirm quiting
    Popup {
        id: popupExit
        width: parent.width
        height: 924
        focus: true
        padding: 2
        //anchors.centerIn: parent
        contentItem: Rectangle {

            color: "white"

            Text {
                id: endText
                x: 15
                y: 150
                font.pixelSize: 20
                font.family: mollen.name
                color: "black"
                text: "Möchtest du Rocksense wirklich beenden?"
                anchors.horizontalCenter: parent.horizontalCenter

            }
            Text {
                id: textAnimation
                text: "EXIT"
                //color: "black"
                font.pixelSize: 200
                font.family: scratch.name
                anchors.topMargin: 75
                anchors.top: endText.bottom
                anchors.horizontalCenter: parent.horizontalCenter

                // color of text changes from black to red and the other way
                SequentialAnimation on color {
                    loops: Animation.Infinite
                    ColorAnimation { from: "black"; to: "#BB1C1C"; duration: 2500 }
                    ColorAnimation { from: "#BB1C1C"; to: "black"; duration: 2500 }
                }

            }

            // row of buttons to cancel or end application
            Row {
                anchors.top: textAnimation.bottom
                anchors.topMargin: 50

                spacing: 100
                anchors.horizontalCenter: parent.horizontalCenter

                Button {
                    text: "Abbrechen"
                    font.family: mollen.name
                    font.pixelSize: 18
                    onClicked: {
                        popupExit.close()
                    }
                }
                Button {
                    text: "Beenden"
                    font.family: mollen.name
                    font.pixelSize: 18
                    onClicked: {
                        popupExit.close()
                        stack.push("StartAnimation.qml")
                    }
                }
            }

        }
    }
}

