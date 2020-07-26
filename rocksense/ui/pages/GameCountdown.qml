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
    property int count: 0
    property int minute: 0
    property int time: 0

    // Method for going to next page
    function goToNextPage()
    {
        stopwatch.running = false
        stack.push("GTAEndResult.qml")
    }

    Background {}

    // timer for the countdown
    Timer {
        id: timerCountdown
        interval: 1000
        running: true
        repeat: true
        onTriggered:
            if (countdown == 0) {
                gamemanager.start_getthemall() // starts get them all
                stopwatch.start() // starts stopwatch
                countdown = -1
            }
            else if (countdown == -1) {
                running = false
            }

            else {
                countdown-=1
            }
    }

    Connections {
        target: gamemanager
        //Signal Handler

        onIsFinished: {
            goToNextPage()
        }


    }

    // shows text based on the countdown
    Text {
        id: readyText
        font.pixelSize: 160
        font.family: mollen.name
        text:
            if (countdown == 4) {
                "Ready?"
            }
            else if (countdown != 0 && countdown != -1) {

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

    Timer {
        id: stopwatch
        interval: 100
        running: false
        repeat: true
        onTriggered:
            if (count === 600) {
                count = 0
                minute +=1
                count += 1
            }
            else {
                count += 1
            }

    }


    Text {
        id: textStopwatch
        font.pixelSize: 180
        font.family: mollen.name
        text: minute + "." + (count/ 10).toFixed(1)
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: readyText.bottom
        anchors.topMargin: 100
    }




}





