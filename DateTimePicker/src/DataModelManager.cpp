#include "DataModelManager.h"

class DataModelManagerPrivate
{
public:
    DataModelManagerPrivate(DataModelManager *parent)
        : q_ptr(parent)
    {}

private:
    DataModelManager * const q_ptr;
    Q_DECLARE_PUBLIC(DataModelManager)
};

DataModelManager::DataModelManager(QObject *parent) :
    QObject(parent) ,
    d_ptr(new DataModelManagerPrivate(this))
{
}

DataModelManager::~DataModelManager()
{
}
