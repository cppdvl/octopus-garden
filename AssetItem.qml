import QtQuick 2.0

Rectangle {
    id: assetItem

    property var selectionCallback : (index) => {console.log(index)}
    Component.onCompleted: {
        assetItem.selected.connect(selectionCallback);
    }

    property string caption : "--=--"
    property string assetType : "folder"
    property int index : 0
    property string source : "qrc:/assets/images/GenericImage"

    property var mapTypeImage : {
        "folder" : "qrc:/assets/images/GenericFolder",
        "image" : source
    }

    signal selected(int index);

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
        onClicked: {
            assetItem.selected(assetItem.index)
        }

        anchors.fill:parent
        hoverEnabled: true
    }
}
