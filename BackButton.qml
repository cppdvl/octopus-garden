import QtQuick 2.0

Item {
    property real sizeFactor : 0.05
    width: parent.width * sizeFactor
    height: parent.height * sizeFactor
    Rectangle {
        width: parent.width
        height: parent.width
        color: "transparent"
        border.color: "red"
        radius: width*0.4
    }
}
