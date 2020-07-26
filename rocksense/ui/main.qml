import QtQuick 2.2
import QtQuick.Controls 2.2
import QtQuick.Window 2.2
import "items/."
import "pages/."
import "images/."


// main window

ApplicationWindow {
    id: mainpage
    title: qsTr("RockSense")
    maximumHeight: 1024
    maximumWidth: 600
    width: 600
    height: 1024
    visible: true
    visibility: "FullScreen"

    // menubar with buttons, which are shown in the full application
    menuBar: BorderImage {
        border.bottom: 8
        width: parent.width
        height: opacity ? 100 : 0
        source: "images/MenuBar.png"
        opacity: stack.depth > 1 ? 1 : 0

        // button to the page before
        Rectangle {
            id: backButton
            width: opacity ? 60 : 0
            anchors.left: parent.left
            anchors.leftMargin: 20
            opacity: stack.depth > 1 ? 1 : 0 //not visible on first page
            anchors.verticalCenter: parent.verticalCenter
            antialiasing: true

            height: 60
            radius: 4
            color: "transparent"
            Behavior on opacity { NumberAnimation{} }
            Image {
                anchors.verticalCenter: parent.verticalCenter
                source: "images/back.png"
            }
            MouseArea {
                id: backmouse
                anchors.fill: parent
                anchors.margins: -10
                onClicked: stack.pop()
            }
        }

        // button to the user selection
        Rectangle {
            id: userButton
            width: opacity ? 60 : 0
            opacity: stack.depth > 1 ? 1 : 0 //not visible on first page
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            antialiasing: true
            height: 60
            radius: 4
            color: "transparent"
            Behavior on opacity { NumberAnimation{} }
            Image {
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                source: "images/user.png"
            }
            MouseArea {
                id: userMouse
                anchors.fill: parent
                anchors.margins: -10
                onClicked: {
                    stack.push("pages/UserSelection.qml")

                }
            }
        }

        // button to the general settings like wall selection or the end button
        Rectangle {
            id: settingsButton
            width: opacity ? 60 : 0
            opacity: stack.depth > 1 ? 1 : 0 //not visible on first page
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 20
            antialiasing: true
            height: 60
            radius: 4
            color: "transparent"
            Behavior on opacity { NumberAnimation{} }
            Image {
                width: 40
                height: 40
                anchors.verticalCenter: parent.verticalCenter
                source: "images/settings.png"
            }
            MouseArea {
                id: generalSettingsMouse
                anchors.fill: parent
                anchors.margins: -10
                onClicked: stack.push("pages/GeneralSettings.qml")
            }
        }

        Text {
            id: menuText
            font.pixelSize: 42
            Behavior on x { NumberAnimation{ easing.type: Easing.OutCubic} }
            x: backButton.x + backButton.width + 20
            anchors.verticalCenter: parent.verticalCenter
            color: "white"
            text: ""
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: stack.push("pages/UserSelection.qml")
    }

    StackView {
        id: stack
        initialItem: StartAnimation {}
    }
}


