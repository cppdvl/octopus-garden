#include "staticfetch.h"
#include <QNetworkRequest>
#include <QDebug>
#include <QString>
#include <QJsonArray>
#include <QJsonObject>
#include <QJsonDocument>
#include <QTextStream>

StaticFetchModel::StaticFetchModel(QObject *parent, const QUrl qUrl) : QObject(parent), qUrl(qUrl)
{
    refresh();
}

void StaticFetchModel::refresh(){

    auto request = QNetworkRequest{qUrl};
    request.setHeader(QNetworkRequest::UserAgentHeader, QVariant{"ChallengeUnderTheSeaAOBOARD"});

    pReply = networkManager.get(request);

    QObject::connect(pReply, &QNetworkReply::finished, [&](){

        dataModel.clear();
        dataModel = pReply->readAll(); pReply->close(); pReply->deleteLater();

        auto dataModelUTF8 = QString(dataModel).toUtf8();
        auto doc = QJsonDocument::fromJson(dataModelUTF8);

        jsonModel = doc.isArray() ? doc.array() : QJsonArray{};
        if (!jsonModel.empty()) emit modelRefreshed();
    });



}
