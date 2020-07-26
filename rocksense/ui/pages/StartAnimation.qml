import QtQuick 2.2
import QtQuick.Controls 2.2
import "../items/."
import "../pages/."
import "../fonts/."

Page {

    width: 600
    height: 1024

    FontLoader { id: badGrunge; source: "../fonts/badGrunge.ttf" }
    FontLoader { id: scratch; source: "../fonts/Scratch.otf" }

    // background image
    Image {
        source: "../images/Background.jpg"
        anchors.fill: parent
    }

    // next page
    MouseArea {
        id: mouse
        anchors.fill: parent
        enabled: true
        onClicked: {
            wallmanager.start_startshow()
            stack.push("UserSelection.qml")
        }
    }

    Text {
        id: rocksense
        text: qsTr("RockSense")
        horizontalAlignment: Text.AlignHCenter
        anchors.horizontalCenter: parent.horizontalCenter
        y: 345
        font.family: badGrunge.name
        font.pixelSize: 170
        opacity: 0
    }

    Text {
        id: keep
        anchors.top: rocksense.bottom
        text: qsTr("Keep the track")
        anchors.topMargin: 45
        style: Text.Normal
        font.capitalization: Font.AllUppercase
        anchors.horizontalCenter: parent.horizontalCenter
        horizontalAlignment: parent.horizontalCenter
        font.family: scratch.name
        font.pixelSize: 60
        opacity: 0

    }


    SequentialAnimation {
        running: true //animation starts automatically

        // RockSense fade in
        ParallelAnimation {
            id: first
            readonly property int duration: 4000
            NumberAnimation {
                target: rocksense
                property: "opacity" // visibility
                to: 1
                duration: first.duration * 0.75
            }

            NumberAnimation {
                target: rocksense
                property: "scale"
                from: 2
                to: 1
                duration: first.duration
                easing.type: Easing.OutBounce
            }
            RotationAnimation {
                target: rocksense //rotation of text
                from: 180
                to: 360
                duration: first.duration * 0.5
            }
        }
        // Keep the track fade in
        ParallelAnimation {
            id: second
            readonly property int duration: 2500
            NumberAnimation {
                target: keep
                property: "opacity"
                to: 1
                duration: second.duration * 0.5
            }
            NumberAnimation {
                target: keep
                property: "scale"
                from: 2
                to: 1
                duration: second.duration
                easing.type: Easing.OutBounce
            }
        }
    }
}
