import QtQuick 2.2
import QtQuick.Controls 2.2
import "../items/."
import "../images/."
import "../fonts/."


Page {

    id: helloNewUser
    width: 600
    height: 924

    // welcoming the new user

    FontLoader { id: mollen; source: "../fonts/MollenRegular.otf" }
    FontLoader { id: scratch; source: "../fonts/Scratch.otf" }

    Background {
        id: background
        anchors.fill: parent

        Footer {
            id: footer
            text: "Los gehts!"

            RoundButton {
                id: roundButton
                height: 70
                width: 70
                anchors.right: parent.right
                anchors.rightMargin: 30
                anchors.verticalCenter: parent.verticalCenter

                onClicked: {
                    stack.push("Welcome.qml")
                }

                Image {
                    id: plus
                    x: 15
                    y: 15
                    width: 40
                    height: 40
                    source: "../images/nextBlack.png"
                }
            }
        }


        // welcome text for the new user
        Text {
            id: greeting
            text: qsTr("Schön, dich bei uns \nbegrüßen zu dürfen, \n" + usermanager.show_current_user_name()  + "!")
            anchors.top: parent.top
            anchors.topMargin: 170
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignHCenter
            font.family: mollen.name
            font.pixelSize: 40
            opacity: 0
        }

        Text {
            id: warmup
            text: "Wie wäre es mit ein paar Aufwärmübungen,\n während dein Profil angelegt wird?"
            anchors.top: greeting.bottom
            anchors.topMargin: 70
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignHCenter
            font.family: mollen.name
            font.pixelSize: 20
            opacity: 0
        }

        // shows winnie pooh gif
        AnimatedImage {
            id: gif
            anchors.top: warmup.bottom
            anchors.topMargin: 50
            width: 392
            height: 199
            source: "../images/WinnieStretch.gif"
            anchors.horizontalCenter: parent.horizontalCenter
            playing: true
            opacity: 0
        }

    }

    // animations for text an gif
    SequentialAnimation {
        running: true //animation starts automatically

        // Welcome animation
        ParallelAnimation {
            id: first
            readonly property int duration: 2500
            NumberAnimation {
                target: greeting
                property: "opacity"
                to: 1
                duration: first.duration * 0.75
            }
            NumberAnimation {
                target: greeting
                property: "scale"
                from: 0
                to: 1
                duration: first.duration
                easing.type: Easing.OutCirc
            }
        }
        // Warm-up animation
        ParallelAnimation {
            id: second
            readonly property int duration: 500
            NumberAnimation {
                target: warmup
                property: "opacity"
                to: 1
                duration: second.duration * 0.5
            }
            NumberAnimation {
                target: warmup
                property: "scale"
                from: 0
                to: 1
                duration: first.duration
                easing.type: Easing.OutCirc
            }

        }
        // gif animation
        ParallelAnimation {
            id: third
            readonly property int duration: 500
            NumberAnimation {
                target: gif
                property: "opacity"
                to: 1
                duration: second.duration * 0.5
            }
            NumberAnimation {
                target: gif
                property: "scale"
                from: 0
                to: 1
                duration: third.duration * 0.9
                easing.type: Easing.OutCirc
            }
        }
    }


}

