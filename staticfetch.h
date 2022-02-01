#ifndef STATICFETCH_H
#define STATICFETCH_H

#include <QColor>
#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QJsonArray>
#include <QStack>

class StaticFetchModel : public QObject
{
    Q_OBJECT
    QJsonArray data;
    QJsonArray currentFolderModel;
    QStack<QJsonArray> parentFolderModel;

    void calculateDataToRender();
    void refresh();

public:
    explicit StaticFetchModel(QObject *parent = nullptr);
    QNetworkAccessManager networkManager{};
    QNetworkReply* pReply;

signals:
    void modelRefreshed(QVariantList lollipop, bool top);

public slots:
    void fetchItem(int);
    void fetchBack();



};

#endif // STATICFETCH_H
