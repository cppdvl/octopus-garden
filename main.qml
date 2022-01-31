import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.5
import "datacheat.js" as BackendTestData
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

    ListModel {
        id: currentFolderData
        property var parentData : []
    }
    Rectangle {
        width: mainWindow.width
        height: mainWindow.height * 0.025
        x: 0
        y: 0
        Text {
            anchors.fill: parent
            text: currentFolderData.parentData.length

        }
    }

    Row {

        anchors.centerIn: parent
        width: parent.width
        height: parent.height * mainRowHeightFactor


        Rectangle { color: color0; width: parent.width; height: parent.height
            id: gridContainerRectangle
            border.color: "blue"
            Button {
                id: backButton
                text : "Back"
                onClicked : {
                    BackendController.backButtonClickedCallback(gridContainer, currentFolderData);
                    backButton.visible = currentFolderData.parentData.length > 0 ? true : false;
                    console.log("<= parent is now:", currentFolderData.parentData.length)

                }
            }

            Grid {
                id: gridContainer
                y : 100
                columns: 6
                width: parent.width
                spacing: 20
                Component.onCompleted: {

                    // Visible Button should be invisible
                    backButton.visible = currentFolderData.parentData.length > 0 ? true : false

                    // load Static Data
                    let dataLoaded = BackendController.startData(BackendTestData.data)

                    //The assets in the grid and the data in the model
                    BackendController.update(dataLoaded, gridContainer, currentFolderData, (index) => {
                                                 BackendController.assetItemSelectedCallback(gridContainer, currentFolderData, index);
                                                 backButton.visible = currentFolderData.parentData.length > 0 ? true : false;
                                                 console.log("=> parent is now:", currentFolderData.parentData.length)

                                             });

                }
            }
        }
    }

    Component.onCompleted: {

        console.log("Under the sea challenge Jan - 2022 for AppOnBoard!!!");
        BackendController.createAssetItemComponent();
    }

}
