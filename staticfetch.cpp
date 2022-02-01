#include "staticfetch.h"
#include <QNetworkRequest>
#include <QDebug>
#include <QString>
#include <QJsonArray>
#include <QJsonObject>
#include <QJsonDocument>
#include <QTextStream>

StaticFetchModel::StaticFetchModel(QObject *parent) : QObject(parent)
{
    refresh();
}

void StaticFetchModel::fetchItem(int itemIndex)
{
    auto folderElement = currentFolderModel[itemIndex].toObject();
    auto isFolder = folderElement.find("children") != folderElement.end();

    if (isFolder){
        parentFolderModel.push(currentFolderModel);
        currentFolderModel = folderElement["children"].toArray();
        calculateDataToRender();

    } else {
        //Do nothing
    }

}

void StaticFetchModel::fetchBack()
{
    Q_ASSERT(parentFolderModel.empty() == false);
    currentFolderModel = parentFolderModel.pop();
    calculateDataToRender();
}

void StaticFetchModel::calculateDataToRender()
{
    auto dataToRender = QJsonArray{};
    for (auto folderElementInaccesibleRef : currentFolderModel){

        auto folderElement = folderElementInaccesibleRef.toObject();
        auto folderElementIsAnImage = folderElement.find("children") != folderElement.end();
        QJsonObject o {
            {"name",        folderElement["name"].toString()},
            {"source",      folderElement["icon"].toString()},
            {"isFolder",    folderElementIsAnImage}
        };
        dataToRender.push_back(QJsonValue(o));
    }
    emit modelRefreshed(dataToRender.toVariantList(), parentFolderModel.empty());
}

void StaticFetchModel::refresh(){

    auto request = QNetworkRequest{QUrl{"https://s3.amazonaws.com/com.buildbox.dev.interview/UnderTheSea/data.json"}};
    request.setHeader(QNetworkRequest::UserAgentHeader, QVariant{"ChallengeUnderTheSeaAOBOARD"});

    pReply = networkManager.get(request);

    QObject::connect(pReply, &QNetworkReply::finished, [&](){

        auto dataModel = QByteArray{};
        dataModel.clear();
        dataModel = pReply->readAll(); pReply->close(); pReply->deleteLater();

        auto dataModelUTF8 = QString(dataModel).toUtf8();
        auto doc = QJsonDocument::fromJson(dataModelUTF8);

        data = doc.isArray() ? doc.array() : QJsonArray{};


        if (!data.empty()){

            currentFolderModel = QJsonArray{};
            parentFolderModel = QStack<QJsonArray>{};
            currentFolderModel = data;
            calculateDataToRender();

        } else Q_ASSERT(false);
    });



}
