import QtQuick 2.0
import QtQuick.Window 2.12
import QtQuick.Controls 2.5

import "backend.js" as BackendController
import under.the.sea.challenge 1.0

Window {

    id: mainWindow
    width: 1200
    height: 800
    visible: true
    title: qsTr("Hello World")
    color: "transparent"


    property string color0: "#2696D9"
    property string color1: "#C226D9"
    property string color2: "#D96926"
    property string color3: "#3DD926"

    UTSCDataModel{
        id: utscData
        onModelRefreshed: (currentFolderData, top) =>
        {
            BackendController.update(currentFolderData, gridContainer, (index) => { utscData.fetchItem(index); });
            backButton.visible = top ? false : true;
        }
    }

    Row {

        anchors.fill: parent

        Rectangle { color: color0; width: parent.width; height: parent.height
            id: gridContainerRectangle
            border.color: "blue"
            Button {
                id: backButton
                text : "Back"
                onClicked : {
                    utscData.fetchBack();
                }
                visible: false
            }

            Grid {
                id: gridContainer
                y : 100
                columns: 4
                width: parent.width
                spacing: 20
            }
        }
    }

    Component.onCompleted: {

        console.log("Under the sea challenge Jan - 2022 for AppOnBoard!!!");
        BackendController.createAssetItemComponent();
    }

}
