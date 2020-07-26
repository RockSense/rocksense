import QtQuick 2.2
import QtQuick.Controls 2.2 //Page
import "../items/."
import "../images/."
import "../pages/."
import "../fonts/."


Page {
    id: userselection
    title: qsTr("Userauswahl")
    width: 600
    height: 924

    FontLoader { id: scratch; source: "../fonts/Scratch.otf" }
    FontLoader { id: mollen; source: "../fonts/MollenRegular.otf" }

    Background {

        Description { text: "Bitte wähle deinen User aus. Falls du noch keinen hast, lege dir bitte einen an." }

        // user list for selecting current user
        Rectangle {
            width: parent.width
            height: 685
            color: "transparent"
            //anchors.top: parent.top
            anchors.topMargin: 90

            ListView {
                id: pythonList
                width: parent.width
                height: parent.height

                model: userListModel

                delegate: Component {
                    Rectangle {
                        width: pythonList.width
                        height: 100
                        color: ((index % 2 == 0)?"#f2f3f4":"lightgrey")

                        Text {
                            id: title
                            elide: Text.ElideRight
                            text: model.display
                            color: "black"
                            font.pixelSize: 40
                            font.family: scratch.name
                            anchors.leftMargin: 10
                            anchors.fill: parent
                            verticalAlignment: Text.AlignVCenter
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                // userListModel.currentIndex = index
                                // print(index) just for checking
                                usermanager.set_current_user(index)
                                stack.push("Welcome.qml")
                            }
                        }

                    }

                }
            }



        }
        // button to create a new user
         Rectangle {
                id: footer
                width: parent.width
                height: 150
                color: "#3a4055"
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 0

                Text {
                    id: footerText
                    text: "Bist du neu hier?"
                    font.pointSize: 25
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.leftMargin: 100
                    color: "white"
                    font.family: mollen.name
                }

                RoundButton {
                    width: 70
                    height: 70
                    anchors.right: parent.right
                    anchors.rightMargin: 30
                    onClicked: stack.push("NewUser.qml")
                    anchors.verticalCenter: footer.verticalCenter
                    visible: true

                    Image {
                        id: plus
                        x: 15
                        y: 15
                        width: 40
                        height: 40
                        source: "../images/plusBlack.png"
                    }
                }

            }



    }

}

