import QtQuick 2.2
import QtQuick.Controls 2.2
import "../items/."
import "../fonts/."

Page {
    id: page
    width: 600
    height: 924

    FontLoader { id: mollen; source: "../fonts/MollenRegular.otf" }


    property int countdown: 4
    //property int count: 59 //Sekunden
    property int minute: 0
    property int second: 0

    Background {}

    function getTimer(){
         minute = (gamemanager.set_timer() / 60)
    }

    // timer for the countdown
    // transformation of the game time in seconds to minutes and seconds
    Timer {
        id: timerCountdown
        interval: 1000
        running: true // runs automatically
        repeat: true
        onTriggered:
            if (countdown == 0) {
                countdown = -1
                second = (gamemanager.set_timer()%60)
                minute = (gamemanager.set_timer()/60)
                gamemanager.start_catchit() /7 starts the game
                timerGame.start() // starts the timerr

            }
            else if (countdown == -1 || countdown == -2) {
                running = false // stops the timerCountdown
            }

            else {
                countdown-=1 // text is not shown
            }

    }


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


    // shows the text of the countdown
    Text {
        id: readyText
        font.pixelSize: 160
        font.family: mollen.name
        anchors.top: parent.top
        anchors.topMargin: 50
        text:
            if (countdown == 4) {
                "Ready?"
            }
            else if (countdown != 0 && countdown != -1 && countdown != -2) {
                countdown
            }
            else if (countdown == 0) {
                "Go!"
            }

            else {
                ""
            }
        anchors.horizontalCenter: parent.horizontalCenter
    }

    // only visible if time is up
    Text {
        id: timeUp
        text: "Zeit ist vorbei!"
        font.pixelSize: 70
        anchors.top: parent.top
        anchors.topMargin: 50
        font.family: mollen.name
        opacity: countdown != -2 ? 0 : 1
        anchors.horizontalCenter: parent.horizontalCenter
    }

    // shows remaining time
    Text {
        id: textTimer
        font.pixelSize: 180
        font.family: mollen.name
        text: minute + "." + (second)
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: readyText.bottom
        anchors.topMargin: 100
    }

    // stop button and next page button
    Rectangle {
        id: stopButton
        width: 400
        height: 100
        color: "#3a4055"
        anchors.top: textTimer.bottom
        anchors.topMargin: 70
        anchors.horizontalCenter: parent.horizontalCenter

        Text {
            id: element
            height: 36
            text: countdown != -2 ? "Stop" : "Weiter" // shows stop until the time is up
            font.family: mollen.name
            color: "white"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            font.bold: false
            font.pixelSize: 30
        }

        MouseArea {
            id: mouse
            anchors.fill: parent
            onClicked:
                // time is up
                if (countdown == -2) {
                    stack.push("CatchItEndResult.qml")
                }
                // time was stopped
                else {
                timerGame.running = false
                console.log("Rest time: "+minute+":"+second)
                stack.push("CatchItEndResult.qml")

                }
        }

    }

}