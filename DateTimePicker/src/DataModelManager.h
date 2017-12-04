#ifndef DATAMODELMANAGER_H
#define DATAMODELMANAGER_H

#include <QObject>

class DataModelManagerPrivate;

class DataModelManager : public QObject
{
    Q_OBJECT
public:
    explicit DataModelManager(QObject *parent = 0);
    ~DataModelManager();

signals:

public slots:

private:
    QScopedPointer<DataModelManagerPrivate> d_ptr;
    Q_DECLARE_PRIVATE(DataModelManager)
};

#endif // DATAMODELMANAGER_H
