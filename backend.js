var assetItemComponent = null;
var assetItemComponentReady = false;

function createAssetItemComponent()
{
    assetItemComponent = Qt.createComponent("AssetItem.qml");
    assetItemComponent.statusChanged.connect(assetItemComponentCreationDone);

    if (assetItemComponent.status === Component.Ready)
        assetItemComponentCreationDone();

}

function assetItemComponentCreationDone()
{
    assetItemComponentReady = true;
    console.log("AssetItem component now is there....");
}

function createAssetItem(parent, index, name, assetType, source, selectedItemCallback)
{
    assetItemComponent.createObject(parent, {index : index, assetType : assetType, caption : name, source : source, selectionCallback: selectedItemCallback})
}
function updateRender(gridContainer, element, index, selectedItemCallback)
{
    let assetType = element.isFolder ? "folder" : "image";
    createAssetItem(gridContainer, index, element.name, assetType, element.source, selectedItemCallback);
}


function saturnEatYourChildren(gridContainer)
{
    for (let index = gridContainer.children.length; index > 0; --index )
    {
        gridContainer.children[index-1].destroy();
    }
}
function update(dataToRender, gridContainer, selectedItemCallback)
{
    saturnEatYourChildren(gridContainer);
    dataToRender.forEach((element, index) => {
                             updateRender(gridContainer, element, index, selectedItemCallback);
                         });
}






