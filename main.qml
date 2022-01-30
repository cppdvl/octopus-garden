import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.5
import "datacheat.js" as BackendData
import "backend.js" as BackendController
Window {

    id: mainWindow
    width: 1200
    height: 800
    visible: true
    title: qsTr("Hello World")
    color: "transparent"


    property real mainRowHeightFactor : 0.95

    property string color0: "#2696D9"
    property string color1: "#C226D9"
    property string color2: "#D96926"
    property string color3: "#3DD926"

    Row {

        anchors.centerIn: parent
        width: parent.width
        height: parent.height * mainRowHeightFactor

        property real rheight: height
        property real rwidth: width

        Rectangle { color: color0; width: parent.width * 0.30; height: parent.height
            opacity: 0.4
        }
        Rectangle { color: color0; width: parent.width * 0.70; height: parent.height
            id: gridContainerRectangle
            border.color: "blue"
            Grid {
                id: gridContainer
                y : 100
                columns: 6
                width: parent.width
                spacing: 20
                Component.onCompleted: {
                    BackendData.initData(BackendData.data).forEach((element, index) => { BackendController.createAssetItem(gridContainer, element.name, element.assetType, element.source); });
                }
            }
        }
    }

    Component.onCompleted: {

        console.log("Under the sea challenge Jan - 2022 for AppOnBoard!!!");
        BackendController.createAssetItemComponent();
    }

}
