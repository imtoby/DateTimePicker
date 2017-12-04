#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QDate>
#include <QStringList>
#include <QDebug>

QDate StartDate(1970, 1, 1);
QDate EndDate(1950, 12, 31);
QStringList DateList;

void InitDateList() {
    QDate date = StartDate;
    DateList.append(date.toString("yyyy-MM-ddd"));
    while (date < EndDate) {
        date.addDays(1);
        DateList.append(date.toString("yyyy-MM-ddd"));
    }

    qDebug() << DateList;
}

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    InitDateList();

    return app.exec();
}
