#ifndef STATICFETCH_H
#define STATICFETCH_H

#include <QColor>
#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QJsonArray>

class StaticFetchModel : public QObject
{
    Q_OBJECT
    QJsonArray data;
    QJsonArray currentFolderModel;
    QJsonArray parentFolderModel;
    QVector<QString> currentFolderData{};
    QUrl qUrl;

    void refresh();

public:

    explicit StaticFetchModel(QObject *parent = nullptr);
    QNetworkAccessManager networkManager{};
    QNetworkReply* pReply;

    QVariantList varlist();

signals:
    void modelRefreshed(QVariantList lollipop, bool top);
public slots:
    void fetchItem(int);
    void fetchBack();



};

#endif // STATICFETCH_H
