#ifndef QRQUESTRESULT_H
#define QRQUESTRESULT_H

#include <QObject>
#include <QDebug>

class QRequests : public QObject
{
    Q_OBJECT
public:
//    QRequests() {
//    }
//    virtual ~QRequests() {
//    }
private slots:
    void setRequestsList(int row, QString operation, int delay){
        emit setValueOperation(row, "<font color='GREEN'>"+operation+"</font>", "", "<font color='BLUE'>Waiting...</font>", delay);//Запись операции в очередь
    }

signals:
    void setValueOperation(int _row, QString _operation = "", QString _results = "", QString _status = "", int _delay = 0);
};


#endif // QRQUESTRESULT_H
