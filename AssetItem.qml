import QtQuick 2.0

Rectangle {

    property string caption : "--=--"
    property string assetType : "folder"

    property string source : "qrc:/assets/images/GenericImage"
    property var mapTypeImage : {
        "folder" : "qrc:/assets/images/GenericFolder",
        "image" : source
    }

    id: assetItem
    color: "transparent"
    width: 100
    height: width
    border.color : "transparent"
    Rectangle {
        clip: true
        anchors.fill: parent
        color: "transparent"
        Image {
            id:spinImg
            source: "qrc:/assets/images/Spinning"
            width: parent.width * .25
            fillMode: Image.PreserveAspectFit
            anchors.centerIn: parent
            opacity: (1.0 - img.progress)
        }

        Image {
            id: img
            source: mapTypeImage[assetType]
            width: parent.width
            fillMode: Image.PreserveAspectFit
            anchors.centerIn: parent
        }
    }

    Text {
        antialiasing: true
        id: captionText
        text: qsTr(caption)
        anchors.top : parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
    }

    MouseArea {

        id: miceArea
        onEntered: {
            assetItem.color = "aqua"
        }
        onExited: assetItem.color = "transparent"

        anchors.fill:parent
        hoverEnabled: true
    }
}
