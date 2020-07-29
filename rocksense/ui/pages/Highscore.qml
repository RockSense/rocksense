import QtQuick 2.2
import QtQuick.Controls 2.2
import "../items/."
import "../fonts/."


Page {
    id: highscore
    title: qsTr("Highscore")
    width: 600
    height: 924

    FontLoader { id: scratch; source: "../fonts/Scratch.otf" }
    FontLoader { id: mollen; source: "../fonts/MollenRegular.otf" }

    property bool showRoute: false
    property bool showRouteDetails: false
    property bool showGame: false

    Background {}

    Text {
        id: heading
        text: qsTr("Bestenliste")
        anchors.top: parent.top
        anchors.topMargin: 50
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: 60
        font.family: scratch.name
    }

    //checkboxes for selecting the view
    Row {
        id: checkboxes
        anchors.top: heading.bottom
        anchors.topMargin: 70
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 15

        CheckBox {
            id: routen
            checkable: true
            text: qsTr("Routenergebnisse anzeigen")
            font.family: mollen.name
            font.pointSize: 14
            onClicked: { // routes true
                games.checked = false
                if (checked === true) {
                    showRoute = true
                }
                showGame = false
                gamesRectangle.opacity = 0 //visibility
            }
            onCheckStateChanged: {
                if (showRoute === false) {
                    showRoute = true
                    console.log("route true")
                    routesRectangle.opacity = 1
                }
                else if (showRoute === true) {
                    showRoute = false
                    console.log("route false")
                    routesRectangle.opacity = 0
                }

            }

        }
        CheckBox {
            id: games
            checkable: true
            text: qsTr("Gameergebnisse anzeigen")
            font.pointSize: 14
            font.family: mollen.name
            onClicked: { // game true
                routen.checked = false
                if (checked === true) {
                    showRouteDetails = false
                    showGame = true

                }
                showRoute = false
                routesRectangle.opacity = 0
            }
            onCheckStateChanged: {
                if (showGame === false) {
                    showGame = true
                    console.log("game true")
                    gamesRectangle.opacity = 1
                }
                else if (showGame === true) {
                    showGame = false
                    console.log("game false")
                    gamesRectangle.opacity = 0
                }
            }

        }
    }

    // list of the highscore of the routes
    Rectangle {
        id: routesRectangle
        y: 231
        width: parent.width
        height: 600
        color: "#00000000"
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter
        opacity: showRoute ? 1 : 0

        ListView {
            id: pythonRouteList
            anchors.fill: parent

            model: routeListModel // model for routes

            delegate: Component {
                Rectangle {
                    width: pythonRouteList.width
                    height: 100
                    color: ((index % 2 == 0)?"#f2f3f4":"lightgrey")

                    Text {
                        id: routeTitle
                        elide: Text.ElideRight
                        text: model.display
                        color: "black"
                        font.pixelSize: 30
                        anchors.leftMargin: 10
                        anchors.fill: parent
                        font.family: scratch.name
                        verticalAlignment: Text.AlignVCenter
                    }

                    MouseArea {
                        id: routeMouse
                        anchors.fill: parent
                        onClicked: {
                            routeListModel.currentIndex = index
                            //print(index) //just for checking
                            //routemanager.set_current_route(index)
                            showRouteDetails = true // show detail page

                        }
                    }
                }
            }
        }
    }

    // shows details to the route highscore
    Rectangle {
        id: routeDetails
        y: 231
        width: 500
        height: 600
        color: "white"
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter
        opacity: showRouteDetails ? 1 : 0

        Text {
                id: headingRoute
                text: "Routenergebnisse"
                font.pixelSize: 50
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: scratch.name
        }

        Text {
                id: first
                text: "1. Platz: " 
                anchors.top: headingRoute.bottom
                anchors.topMargin: 100
                font.pixelSize: 35
                font.family: mollen.name
                anchors.horizontalCenter: parent.horizontalCenter

        }
        Text {
                id: second
                text: "2. Platz: "
                anchors.top: first.bottom
                anchors.topMargin: 100
                font.pixelSize: 35
                font.family: mollen.name
                anchors.horizontalCenter: parent.horizontalCenter

        }
        Text {
                id: third
                text: "3. Platz: "
                anchors.top: second.bottom
                anchors.topMargin: 100
                font.pixelSize: 35
                font.family: mollen.name
                anchors.horizontalCenter: parent.horizontalCenter

        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                showRouteDetails = false
            }
        }

    }


    // shows highscores of games
    Rectangle {
        id: gamesRectangle
        y: 231
        width: 500
        height: 600
        color: "transparent"
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter
        opacity: showGame ? 1 : 0

        // views can be swiped
        SwipeView {
            anchors.fill: parent
            id: view2
            currentIndex: 1

            Item {
                id: getThemAll

                    Text {
                        id: headingGetThemAll
                        text: "Get Them All"
                        font.pixelSize: 50
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.family: scratch.name
                    }

                    Text {
                        id: getFirst
                        text: "1. Platz: " + gamemanager.get_score(0, 0)
                        anchors.top: headingGetThemAll.bottom
                        anchors.topMargin: 100
                        font.pixelSize: 35
                        font.family: mollen.name
                        anchors.horizontalCenter: parent.horizontalCenter

                    }
                    Text {
                        id: getSecond
                        text: "2. Platz: " + gamemanager.get_score(1, 0)
                        anchors.top: getFirst.bottom
                        anchors.topMargin: 100
                        font.pixelSize: 35
                        font.family: mollen.name
                        anchors.horizontalCenter: parent.horizontalCenter

                    }
                    Text {
                        id: getThird
                        text: "3. Platz: " + gamemanager.get_score(2, 0)
                        anchors.top: getSecond.bottom
                        anchors.topMargin: 100
                        font.pixelSize: 35
                        font.family: mollen.name
                        anchors.horizontalCenter: parent.horizontalCenter

                    }



            }
            Item {
                id: catchIt

                    Text {
                        id: headingCatchIt
                        text: "Catch It"
                        font.pixelSize: 50
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.family: scratch.name
                    }

                    Text {
                        id: catchFirst
                        text: "1. Platz: " + gamemanager.get_score(0,1)
                        anchors.top: headingCatchIt.bottom
                        anchors.topMargin: 100
                        font.pixelSize: 35
                        font.family: mollen.name
                        anchors.horizontalCenter: parent.horizontalCenter

                    }
                    Text {
                        id: catchSecond
                        text: "2. Platz: " + gamemanager.get_score(1,1)
                        anchors.top: catchFirst.bottom
                        anchors.topMargin: 100
                        font.pixelSize: 35
                        font.family: mollen.name
                        anchors.horizontalCenter: parent.horizontalCenter

                    }
                    Text {
                        id: catchThird
                        text: "3. Platz: " + gamemanager.get_score(2,1)
                        anchors.top: catchSecond.bottom
                        anchors.topMargin: 100
                        font.pixelSize: 35
                        font.family: mollen.name
                        anchors.horizontalCenter: parent.horizontalCenter

                    }


            }


        }

        // shows current game highscore
        PageIndicator {
            id: indicatorGame

            count: view2.count
            currentIndex: view2.currentIndex

            anchors.bottom: view2.bottom
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }


}

