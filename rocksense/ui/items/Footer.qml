import QtQuick 2.0

import "../items/."
import "../fonts/."


Rectangle {
    id: footer
    width: parent.width
    height: 150
    color: "#3a4055"
    anchors.bottom: parent.bottom
    anchors.bottomMargin: 0

    FontLoader { id: mollen; source: "../fonts/MollenRegular.otf" }

    // content can be adapted on every single footer
    property alias text: footerText.text

    Text {
        id: footerText
        font.pointSize: 35
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 100
        color: "white"
        font.family: mollen.name
    }

}
