import QtQuick 2.2
import QtQuick.Controls 2.2 //Page
import "../items/."
import "../images/."
import "../pages/."
import "../fonts/."



Page {
    id: userselection
    title: qsTr("Neue Route anlegen")
    width: 600
    height: 924

    // loads the image with the holds
    background: Image {
        anchors.fill: parent
        source: "../images/Hintergrund.png"
    }

    FontLoader { id: scratch; source: "../fonts/Scratch.otf" }

    Description { text: "Bitte wähle alle Griffe für deine eigene Route aus und bestätige anschließend deine Auswahl"}

    Rectangle {
        id: newRouteRectangle
        y: 168
        width: 500
        height: 700
        color: "#00000000"
        anchors.rightMargin: 20
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter

        // grid of all selectable holds of the wall
        Grid {
            width: 500
            height: 700
            anchors.verticalCenterOffset: -31
            anchors.horizontalCenterOffset: 16
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            columns: 3
            columnSpacing: 150
            rowSpacing: 25
            rows: 9


            //repeated holds with index 0-26
            Repeater {
                model: 27
                Rectangle {
                    width: 55
                    height: 55
                    radius: width * 0.5
                    color: isSelected ? "white" : "transparent"
                    property bool isSelected: false
                    opacity: 0.5

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            // holds can be selected which changes the color

                            if (isSelected === true) {
                                isSelected = false

                                // transformation of grid index to wall logic
                                routemanager.remove_from_hold_list(8+(-1/3)*(index)+(index%3)*(1/3)+9*(index%3))
                                console.log("Hold " + index + " not pressed")

                            }
                            else if (isSelected === false) {
                                isSelected = true
                                routemanager.add_to_hold_list(8+(-1/3)*(index)+(index%3)*(1/3)+9*(index%3))
                                console.log("Hold " + index + " pressed")
                            }
                        }
                    }
                }
            }
        }

        RoundButton {
            id: roundButton
            x: 131
            y: 685
            width: 238
            height: 40
            text: "Route anlegen"
            anchors.bottom: parent.bottom
            anchors.bottomMargin: -25
            highlighted: true
            font.pointSize: 20
            font.family: scratch.name

            onClicked: {
                routemanager.add_new_route() // adds new route
                stack.push("RouteSelection.qml")
            }
        }
    }
}
