import QtQuick 2.0

Rectangle {

    property bool isFolder : false
    property string caption : "--=--"
    property string assetType : "folder"

    property var mapTypeImage : {
        "folder" : "qrc:/assets/images/GenericFolder",
        "image" : "qrc:/assets/images/GenericImage"
    }


    id: assetItem
    color: "aqua"
    width: 100
    height: width
    border.color: "red"

    Image {
        id: img
        source: mapTypeImage[assetType]
        width: parent.width
        fillMode: Image.PreserveAspectFit
    }
    Text {
        id: captionText
        text: qsTr(caption)
        anchors.top : img.bottom

    }
}
