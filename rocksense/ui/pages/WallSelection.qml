import QtQuick 2.2
import QtQuick.Controls 2.2
import "../items/."
import "../pages/."
import "../fonts/."


Page {

    FontLoader { id: mollen; source: "../fonts/MollenRegular.otf" }

    id: wall
    title: qsTr("Wandauswahl")
    width: 600
    height: 924

    Background {
        id: background

        Description {
            text: "Bitte wähle deine Wand aus."
        }

            // sets the prototype wall to current wall
            Rectangle {
                id: prototypWall
                width: 300
                height: 300
                color: "white"
                anchors.top: parent.top
                anchors.topMargin: 80
                anchors.horizontalCenter: parent.horizontalCenter

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        wallmanager.set_current_wall(0)
                        stack.push("Welcome.qml")
                    }
                }

                Text {
                    id: prototypWallTextHolds
                    color: "black"
                    text: qsTr("3 x 9")
                    font.family: mollen.name
                    font.bold: true
                    horizontalAlignment: Text.AlignHCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pixelSize: 60
                }

                Text {
                    id: prototypWallText
                    y: 215
                    text: qsTr("Prototypwand")
                    font.family: mollen.name
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pixelSize: 30
                }

            }
            // sets the standard wall to current wall‚
            Rectangle {
                id: standardWall
                width: 300
                height: 300
                color: "white"
                anchors.top: prototypWall.bottom
                anchors.topMargin: 100
                anchors.horizontalCenter: parent.horizontalCenter

                MouseArea {
                    id: standardWallMouse
                    anchors.fill: parent
                    onClicked: {
                        wallmanager.set_current_wall(1)
                        stack.push("Welcome.qml")
                    }
                }

                Text {
                    id: standardWallTextHolds
                    color: "black"
                    text: qsTr("10 x 20")
                    //anchors.verticalCenterOffset: 1
                    //anchors.horizontalCenterOffset: 0
                    font.bold: true
                    font.family: mollen.name
                    horizontalAlignment: Text.AlignHCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pixelSize: 60
                }
                Text {
                    id: standardWallText
                    y: 211
                    text: qsTr("Standardwand")
                    //anchors.horizontalCenterOffset: 1
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pixelSize: 30
                    font.family: mollen.name
                    horizontalAlignment: Text.AlignHCenter
                }
            }

    }
}
