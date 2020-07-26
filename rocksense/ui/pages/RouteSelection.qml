import QtQuick 2.2
import QtQuick.Controls 2.2 //Page
import "../items/."
import "../images/."
import "../pages/."
import "../fonts/."


Page {
    id: routeSelection
    title: qsTr("Userauswahl")
    width: 600
    height: 924

    FontLoader { id: scratch; source: "../fonts/Scratch.otf" }
    FontLoader { id: mollen; source: "../fonts/MollenRegular.otf" }


    Background {

            Description { text: "Auf welche Route hast du heute Lust?" }

            // shows list of routes to select one
            Rectangle {
                id: routeListRectangle
                width: parent.width
                height: 685
                color: "transparent"
                anchors.top: parent.top
                anchors.topMargin: 90
                anchors.horizontalCenter: parent.horizontalCenter

                ListView {
                    id: pythonRouteList
                    width: parent.width
                    height: parent.height

                    model: routeListModel // model for the data of the route list

                    delegate: Component { //single routes with text and mouse area
                        Rectangle {
                            width: pythonRouteList.width
                            height: 100
                            color: ((index % 2 == 0)?"#f2f3f4":"lightgrey")

                            Text {
                                id: routeTitle
                                elide: Text.ElideRight
                                text: model.display
                                color: "black"
                                font.pixelSize: 40
                                anchors.leftMargin: 10
                                anchors.fill: parent
                                font.family: scratch.name
                                verticalAlignment: Text.AlignVCenter
                            }

                            MouseArea {
                                id: routeMouse
                                anchors.fill: parent
                                onClicked: {
                                    //print(index) //just for checking
                                    routemanager.set_current_route(index)
                                    stack.push("RouteStartPage.qml")
                                }
                            }
                        }
                    }
                }
            }

    }

    // button to create a new route
    Rectangle {
        id: footer
        width: parent.width
        height: 150
        color: "#3a4055"
        anchors.bottomMargin: 0
        anchors.bottom: parent.bottom

        Text {
            text: "Möchtest du eine eigene Route erstellen?"
            anchors.leftMargin: 22
            font.pointSize: 17
            font.family: mollen.name
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignLeft
            anchors.left: parent.left
            color: "white"
        }

        RoundButton {
            width: 70
            height: 70
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 30
            onClicked: {
                wallmanager.shutdown_leds() // all leds off
                stack.push("NewRouteName.qml")
                }
            visible: true

            Image {
                id: plus
                x: 15
                y: 15
                width: 40
                height: 40
                source: "../images/plusBlack.png"
            }
        }
    }
}
