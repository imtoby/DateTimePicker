#include "DataModelManager.h"
#include <QDate>
#include <QThread>
#include <QDebug>

namespace {
QDate CurrentDate = QDate::currentDate();
QDate StartDate(CurrentDate.year() - 20, 1, 1);
QDate EndDate(CurrentDate.year() + 20, 12, 31);

const QString DATE_BASE_FORMAT("yyyy-MM-dd");
const QString DATE_FORMAT(DATE_BASE_FORMAT + " ddd");
const QString MONTH_FORMAT("yyyy-MM");

QStringList DateList;
int DateInitIndex = 0;

void InitDateList() {
    QDate date = StartDate;
    DateList.append(date.toString(DATE_FORMAT));

    while (date < EndDate) {
        date = date.addDays(1);
        DateList.append(date.toString(DATE_FORMAT));
    }

    if (DateList.size() > 0) {
        DateInitIndex = DateList.indexOf(CurrentDate.toString(DATE_FORMAT));
    }
}

QStringList MonthList;
int MonthInitIndex = 0;

void InitMonthList() {
    QDate date = StartDate;
    MonthList.append(date.toString(MONTH_FORMAT));

    while (date < EndDate) {
        date = date.addMonths(1);
        MonthList.append(date.toString(MONTH_FORMAT));
    }

    if (date.year() != EndDate.year()) {
        MonthList.pop_back();
    }

    if (MonthList.size() > 0) {
        MonthInitIndex = MonthList.indexOf(CurrentDate.toString(MONTH_FORMAT));
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

    QThread workerThread;
};

DataModelManager::DataModelManager(QObject *parent) :
    QObject(parent) ,
    d_ptr(new DataModelManagerPrivate(this))
{
    Q_D(DataModelManager);
    Worker *worker = new Worker;
    worker->moveToThread(&d->workerThread);
    connect(&d->workerThread, &QThread::finished,
            worker, &QObject::deleteLater);
    connect(this, &DataModelManager::initData,
            worker, &Worker::doInitData);
    connect(worker, &Worker::initDataReady,
            this, &DataModelManager::dataModelInitFinished);
    d->workerThread.start();
}

DataModelManager::~DataModelManager()
{
    Q_D(DataModelManager);
    d->workerThread.quit();
    d->workerThread.wait();
}

QStringList DataModelManager::dateModel() const
{
    return DateList;
}

int DataModelManager::dateModelInitIndex() const
{
    return DateInitIndex;
}

QStringList DataModelManager::monthModel() const
{
    return MonthList;
}

int DataModelManager::monthModelInitIndex() const
{
    return MonthInitIndex;
}

void Worker::doInitData()
{
    InitDateList();
    InitMonthList();
    emit initDataReady();
}
