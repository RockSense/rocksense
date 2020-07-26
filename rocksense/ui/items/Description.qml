import QtQuick 2.0
import "../images/."
import "../fonts/."


//

Rectangle {

    FontLoader { id: mollen; source: "../fonts/MollenRegular.otf" }

    color: "white"
    width: parent.width
    height: appText.height + 2 * 20

    // content can be adapted on every single description
    property alias text: appText.text

    Text {
      id: appText
      width: parent.width - 2 * 20
      wrapMode: Text.WordWrap
      anchors.verticalCenter: parent.verticalCenter
      anchors.horizontalCenter: parent.horizontalCenter
      horizontalAlignment: Text.AlignHCenter
      color: "black"
      font.pixelSize: 23
      font.family: mollen.name
    }
}
