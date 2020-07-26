import QtQuick 2.2
import QtQuick.Controls 2.2
import "../items/."
import "../pages/."
import "../fonts/."


Page {
    id: welcome
    width: 600
    height: 924

     // to the next page
     MouseArea {
        id: mouseFullScreenWelcome
        anchors.fill: parent
        onClicked: stack.push("MenuSelection.qml")
     }

    Image {
        source: "../images/Background.jpg"
        anchors.fill: parent
    }

    // variables for chosen user and wall
    property string currentuser: ""
    property string chosenwall: "Prototyp"

    // load fonts for the page with id
    FontLoader { id: mollen; source: "../fonts/MollenRegular.otf" }
    FontLoader { id: badGrunge; source: "../fonts/badGrunge.ttf" }


    // Use QML Component Description
    Description { text: "Schön, dass du wieder da bist!" }

    Text {
        id: welcomeText
        text: qsTr("Willkommen,")
        anchors.top: parent.top
        anchors.topMargin: 150
        anchors.horizontalCenter: parent.horizontalCenter
        style: Text.Normal
        font.weight: Font.Normal
        font.family: badGrunge.name
        font.capitalization: Font.AllUppercase
        verticalAlignment: Text.AlignTop
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 120
    }

    Text {
        id: usertext
        text: qsTr(usermanager.show_current_user_name()  + "!")
        anchors.top: welcomeText.bottom
        anchors.topMargin: 20
        font.capitalization: Font.AllUppercase
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: 120
        font.family: badGrunge.name
        style: Text.Normal
        font.weight: Font.Normal
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignTop
    }


    Rectangle {
        id: footer
        width: parent.width
        height: 150
        color: "#3a4055"
        anchors.bottom: parent.bottom

        Text {
            id: footerText
            text: "Aktuelle Kletterwand: " + chosenwall
            anchors.leftMargin: 10
            anchors.verticalCenter: footer.verticalCenter
            anchors.horizontalCenter: footer.horizontalCenter
            horizontalAlignment: Text.AlignLeft
            color: "white"
            font.family: mollen.name
            font.pixelSize: 23
        }
    }

}


