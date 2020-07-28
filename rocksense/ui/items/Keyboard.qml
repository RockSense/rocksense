import QtQuick 2.0
import QtQuick.VirtualKeyboard 2.1
import QtQuick.VirtualKeyboard.Settings 2.2

Item {
    id: root
    
    Item {
        id: appContainer
        width: parent.width
        height: parent.height/3
        anchors.left: parent.left
        //anchors.top: parent.top
        anchors.right: parent.right
        anchors.bottom: inputPanel.top
    
    }
    InputPanel {
        id: inputPanel
        z: 89
        y: appContainer.height //Qt.inputMethod.visible ? parent.height - inputPanel.height : parent.height
        anchors.left: parent.left
        anchors.right: parent.right
        states: State {
            name: "visible"
            when: inputPanel.active
            PropertyChanges {
                target: inputPanel
                y: root.height - inputPanel.height
                }
            }
        
    }
}