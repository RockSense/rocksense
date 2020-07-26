import QtQuick 2.2
import QtQuick.Controls 2.2
import "../items/."
import "../fonts/."



Page {
    id: page
    width: 600
    height: 924

    FontLoader { id: mollen; source: "../fonts/MollenRegular.otf" }

    property string result : ""

    Background {}

    Text {
        id: congratulation
        text: "Glückwunsch!"
        anchors.top: parent.top
        anchors.topMargin: 200
        font.pointSize: 60
        font.family: mollen.name
        anchors.horizontalCenter: parent.horizontalCenter
        horizontalAlignment: Text.AlignHCenter
    }
    Text {
        id: congratulation2
        text: "Du hast es geschafft!"
        anchors.top: congratulation.bottom
        anchors.topMargin: 50
        font.pointSize: 30
        font.family: mollen.name
        anchors.horizontalCenter: parent.horizontalCenter
        horizontalAlignment: Text.AlignHCenter
    }

    Text {
        text: "Dein erreichtes Ergebnis: "
        anchors.top: congratulation2.bottom
        anchors.topMargin: 100
        anchors.horizontalCenter: parent.horizontalCenter
        font.pointSize: 30
        font.family: mollen.name
        horizontalAlignment: Text.AlignHCenter
    }

    // shows result of the game get them all
    Text {
        id: gtaResultText
        text: gamemanager.show_current_score()
        anchors.top: congratulation2.bottom
        anchors.topMargin: 170
        anchors.horizontalCenter: parent.horizontalCenter
        font.pointSize: 50
    }

    MouseArea {
        anchors.fill: parent
        onClicked: stack.push("MenuSelection.qml")
    }



}

