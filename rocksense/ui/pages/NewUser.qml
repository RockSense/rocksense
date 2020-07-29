import QtQuick 2.2
import QtQuick.Controls 2.2
import "../items/."
import "../fonts/."
import QtQuick.VirtualKeyboard 2.1



Page {

    id: wall
    title: qsTr("Neuen User anlegen")
    width: 600
    height: 924

    FontLoader { id: mollen; source: "../fonts/MollenRegular.otf" }
    FontLoader { id: scratch; source: "../fonts/Scratch.otf" }

    property bool busy: false
    property string username_str: ""

    Background {
        id: background

        // out of the textfield the focus is off
        MouseArea {
            id: mouseArea
            anchors.fill: parent
            onClicked: {
                username.focus = false
            }

            Rectangle {
                id: newUserButton
                y: 590
                width: 400
                height: 100
                color: "#3a4055"
                anchors.horizontalCenterOffset: 0
                anchors.horizontalCenter: parent.horizontalCenter

                Text {
                    id: newUserText
                    height: 36
                    text: "Fertig"
                    color: "white"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    font.bold: true
                    font.family: scratch.name
                    font.pixelSize: 30
                }

                MouseArea {
                    id: newUserMouse
                    anchors.fill: parent
                    onClicked: {
                        usermanager.set_username(username.text) // adds new user
                        stack.push("HelloNewUser.qml")
                    }
                }

            }
        }


        Description {
            text: "Schön, dass du unserer Community beitrittst! \nVerrätst du uns, wie du heißt?"
        }

        // text field for username
        TextField {
            id: username
            anchors.horizontalCenter: parent.horizontalCenter
            height: 50
            width: 200
            color: "black"
            font.pixelSize: 22
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            activeFocusOnPress: true
            placeholderText: "Username"
            font.family: mollen.name
            focus: Qt.inputMethod.visible;

        }
        InputPanel {
        id: keyboard;
        y: parent.height / 4 
        anchors.bottom: parent.bottom
        anchors.left: parent.left;
        anchors.right: parent.right;
        opacity: username.focus ? 1 : 0
        

       }

    }

}
