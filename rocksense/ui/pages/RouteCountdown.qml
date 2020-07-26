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

    // method for going to next page
    function goToNextPage()
    {
        stack.push("RouteEndResult.qml")
    }

    // method for starting the stopwatch
    function startStopwatch()
    {
        stopwatch.start()
    }

    Background {}

    // countdown before starting the stopwatch
    Timer {
        id: timerCountdown
        interval: 1000
        running: true
        repeat: true
        onTriggered:
            if (countdown == 0) {
                routemanager.start_route() //starts route
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
        target: routemanager
        //Signal Handler

        onIsStarted: {
            startStopwatch() // start stopwatch
        }
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
        font.family: mollen.name
        font.pixelSize: 180
        text: minute + "." + (count/ 10).toFixed(1)
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: readyText.bottom
        anchors.topMargin: 100
    }


}





