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

function updateRenderAndDataModel(gridContainer, dataModel, element, index, selectedItemCallback)
{
    //spawn an Item in the Grid.
    createAssetItem(gridContainer, index, element.name, element.assetType, element.source, selectedItemCallback);

    //spawn an Insert an Element in the dataModel.
    dataModel.insert(index, {"name" : element.name, "assetType" : element.assetType, "source" : element.source, "children" : element.children });
}
function generateParentJSON(dataModel)
{
    var parentJSON = []
    for(let index = 0; index < dataModel.count; ++index)
    {
        let listEntry = dataModel.get(index);
        if (listEntry.children === "")
        {
            parentJSON.push({
                                "name" : listEntry.name,
                                "url" : "",
                                "icon" : listEntry.source
                            });
        }
        else
        {
            parentJSON.push({
                                "name" : listEntry.name,
                                "url" : "",
                                "children" : JSON.parse(listEntry.children)
                            });

        }
    }
    return parentJSON;
}

function saturnEatYourChildren(gridContainer)
{
    for (let index = gridContainer.children.length; index > 0; --index )
    {
        gridContainer.children[index-1].destroy();
    }
}

function update(dataLoaded, gridContainer, dataModel, selectedItemCallback)
{
    dataModel.clear();
    saturnEatYourChildren(gridContainer);
    dataLoaded.forEach((element, index) => {
                           updateRenderAndDataModel(gridContainer, dataModel, element, index, selectedItemCallback);
                       });
}


function assetItemSelectedCallback(gridContainer, dataModel, index)
{
    let dataItem = dataModel.get(index)
    if (dataItem.children !== "")
    {
        let parentJSON = generateParentJSON(dataModel);
        dataModel.parentData.push(parentJSON);
        let chldrn = JSON.parse(dataItem.children);
        let dataLoaded = startData(chldrn);
        update(dataLoaded, gridContainer, dataModel, (index) => {assetItemSelectedCallback(gridContainer, dataModel, index);} );
    }
}

function backButtonClickedCallback(gridContainer, dataModel)
{

    let prnt = dataModel.parentData.pop();
    let formattedData = startData(prnt);
    update(formattedData, gridContainer, dataModel, (index) => {assetItemSelectedCallback(gridContainer, dataModel, index);} );

}

function startData(data)
{
    let viewDataParameters = []
    let f = (element, index) => {

        let viewDataParameter = {
            assetType : "children" in element ? "folder" : "image",
            name : element["name"],
            source : "children" in element ? "" : element["icon"],
            children : "children" in element ? JSON.stringify(element["children"]) : ""
        }
        viewDataParameters.push(viewDataParameter);
    };
    data.forEach(f);
    return viewDataParameters;
}




