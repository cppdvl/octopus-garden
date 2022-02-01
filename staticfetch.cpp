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
    qInfo() << "Fetch" << itemIndex;
}

void StaticFetchModel::fetchBack()
{
    qInfo() << "Back!!";
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
        qInfo() << dataModelUTF8;
        auto doc = QJsonDocument::fromJson(dataModelUTF8);

        data = doc.isArray() ? doc.array() : QJsonArray{};


        if (!data.empty()){

            currentFolderModel = QJsonArray{};
            parentFolderModel = QJsonArray{};
            currentFolderModel = data;

            auto dataToRender = QJsonArray{};
            for (auto folderElementInaccesibleRef : currentFolderModel){

                auto folderElement = folderElementInaccesibleRef.toObject();
                auto folderElementIsAnImage = folderElement.find("children") == folderElement.end();
                qInfo() << folderElement["name"].toString();
                QJsonObject o {
                    {"name",        folderElement["name"].toString()},
                    {"source",      folderElement["icon"].toString()},
                    {"isFolder",    folderElementIsAnImage ? false : true}
                };
                dataToRender.push_back(QJsonValue(o));
            }
            emit modelRefreshed(dataToRender.toVariantList(), true);
        }
    });



}
