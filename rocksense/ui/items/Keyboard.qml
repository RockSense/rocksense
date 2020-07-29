import QtQuick 2.0
import QtQuick.VirtualKeyboard 2.1
import QtQuick.VirtualKeyboard.Settings 2.2

Item {
    width: 600
    height: 924
    
    Item {
        id: appContainer
        width: parent.width
        height: parent.height/3
        anchors.centerIn: parent        
     
     InputPanel {
        id: inputPanel
        z: 20
        y: 400//appContainer.height //Qt.inputMethod.visible ? parent.height - inputPanel.height : parent.height
        anchors.left: parent.left
        anchors.right: parent.right          
    }
    }
    
    
    
}