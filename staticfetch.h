#ifndef STATICFETCH_H
#define STATICFETCH_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QJsonArray>

class StaticFetchModel : public QObject
{
    Q_OBJECT
    QByteArray dataModel;
    QJsonArray jsonModel;
    QVector<QString> currentFolderData{};
    QUrl qUrl;
public:
    explicit StaticFetchModel(QObject *parent = nullptr,
                         const QUrl qUrl = QUrl{"https://s3.amazonaws.com/com.buildbox.dev.interview/UnderTheSea/data.json"});
    QNetworkAccessManager networkManager{};
    QNetworkReply* pReply;



signals:
    void modelRefreshed();
public slots:
    void refresh();



};

#endif // STATICFETCH_H
