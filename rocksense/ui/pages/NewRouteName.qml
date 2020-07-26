import QtQuick 2.2
import QtQuick.Controls 2.2
import "../items/."
import "../fonts/."

Page {

    id: wall
    title: qsTr("Neue Route anlegen")
    width: 600
    height: 924

    FontLoader { id: mollen; source: "../fonts/MollenRegular.otf" }
    FontLoader { id: scratch; source: "../fonts/Scratch.otf" }

    property bool busy: false
    property string username_str: ""

    Background {

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            onClicked: {
                username.focus = false
            }

            // button to add a route name
            Rectangle {
                id: newRouteButton
                y: 590
                width: 400
                height: 100
                color: "#3a4055"
                anchors.horizontalCenterOffset: 0
                anchors.horizontalCenter: parent.horizontalCenter

                Text {
                    id: newRouteText
                    height: 36
                    text: "Fertig"
                    color: "white"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    font.bold: false
                    font.family: scratch.name
                    font.pixelSize: 30
                }

                MouseArea {
                    id: newRouteMouse
                    anchors.fill: parent
                    onClicked: {
                        routemanager.set_route_name(routename.text) // adds new route name

                        stack.push("NewRoute.qml")
                    }
                }
            }
        }


        Description {
            text: "Wie soll deine neue Route heißen?"
        }


         // text field for the route name
        TextField {
            id: routename
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            width: 200
            height: 50
            color: "black"
            font.pixelSize: 22
            horizontalAlignment: Text.AlignLeft
            activeFocusOnPress: true
            placeholderText: "Routename"
            text:""
            font.family: mollen.name
        }
    }

}
