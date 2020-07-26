import QtQuick 2.2
import QtQuick.Controls 2.2 //Page
import "../items/."
import "../fonts/."


Page {
    id: menu
    title: qsTr("CatchItStartPage")
    width: 600
    height: 924

    FontLoader { id: mollen; source: "../fonts/MollenRegular.otf" }
    FontLoader { id: scratch; source: "../fonts/Scratch.otf" }

    Background {}

    Text {
        id: catchItText
        text: "Versuche so viele Punkte wie möglich \nzu sammeln, indem du den leuchtenden \nGriff benutzt."
        anchors.top: parent.top
        anchors.topMargin: 100
        horizontalAlignment: Text.AlignHCenter
        font.pointSize: 20
        font.family: mollen.name
        color: "grey"
        anchors.horizontalCenterOffset: 1
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Text {
        id: readyText
        text: "Bist du bereit?"
        anchors.top: catchItText.bottom
        anchors.topMargin: 190
        font.pointSize: 50
        font.family: scratch.name
        anchors.horizontalCenterOffset: 1
        anchors.horizontalCenter: parent.horizontalCenter
    }

    // button to start timer for catch it game
    Rectangle {
        id: startButton
        width: 400
        height: 100
        color: "#3a4055"
        anchors.horizontalCenterOffset: 0
        anchors.top: readyText.bottom
        anchors.topMargin: 150
        anchors.horizontalCenter: parent.horizontalCenter

        Text {
            id: textStartButton
            height: 36
            text: "Starten"
            color: "white"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            font.bold: true
            font.family: mollen.name
            font.pixelSize: 30
        }

        MouseArea {
            id: mouseStartButton
            anchors.fill: parent
            onClicked: stack.push("Timer.qml")
        }

    }

}

