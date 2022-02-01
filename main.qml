import QtQuick 2.0
import QtQuick.Window 2.12
import QtQuick.Controls 2.5
import "datacheat.js" as BackendTestData
import "backend.js" as BackendController
import under.the.sea.challenge 1.0

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

    UTSCDataModel{
        id: currentFolderData
        onModelRefreshed: (lollipop, top) =>
        {
            lollipop.forEach((element, index)=>{
                                 console.log("*************");
                                 console.log("name:", element.name, index);
                                 console.log("source:", element.source, index);
                                 console.log("isFolder:", element.isFolder, index);
                                 console.log("*************");
                             });
            backButton.visible = top ? false : true;

        }
    }

    ListModel {
        id: currentFolderData_
        property var parentData : []
    }
    Rectangle {
        width: mainWindow.width
        height: mainWindow.height * 0.025
        x: 0
        y: 0
        Text {
            anchors.fill: parent
            text: currentFolderData_.parentData.length

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
                    currentFolderData.fetchBack();
                }
            }

            Grid {
                id: gridContainer
                y : 100
                columns: 6
                width: parent.width
                spacing: 20
                Component.onCompleted: {

                    // load Static Data
                    let dataLoaded = BackendController.startData(BackendTestData.data)

                    //The assets in the grid and the data in the model
                    BackendController.update(dataLoaded, gridContainer, currentFolderData_, (index) => {
                                                 BackendController.assetItemSelectedCallback(gridContainer, currentFolderData_, index);
                                                 backButton.visible = currentFolderData_.parentData.length > 0 ? true : false;
                                                 console.log("=> parent is now:", currentFolderData_.parentData.length)

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
