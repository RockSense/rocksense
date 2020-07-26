import QtQuick 2.0

Rectangle {

    id: background

    // color gradient
    gradient: Gradient {
        GradientStop {
            position: 0
            color: "#ffffffff"
        }

        GradientStop {
            position: 1
            color: "darkgrey"
        }
    }
    anchors.fill: parent

}
