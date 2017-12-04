#ifndef DATAMODELMANAGER_H
#define DATAMODELMANAGER_H

#include <QObject>
#include <QStringList>

class Worker : public QObject
{
    Q_OBJECT

public slots:
    void doInitData();

signals:
    void initDataReady();
};

class DataModelManagerPrivate;

class DataModelManager : public QObject
{
    Q_OBJECT
public:
    explicit DataModelManager(QObject *parent = 0);
    ~DataModelManager();

signals:
    void initData();
    void dateModelInitFinished();

public slots:
    QStringList dateModel() const;
    int dateModelInitIndex() const;

private:
    QScopedPointer<DataModelManagerPrivate> d_ptr;
    Q_DECLARE_PRIVATE(DataModelManager)
};

#endif // DATAMODELMANAGER_H
