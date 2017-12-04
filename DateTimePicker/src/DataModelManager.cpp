#include "DataModelManager.h"
#include <QDate>
#include <QStringList>

namespace {

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
}

}

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
