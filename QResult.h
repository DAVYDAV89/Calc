#ifndef QRESULT_H
#define QRESULT_H

#include <QObject>
#include <QDebug>
#include <QMutex>

class QResult : public QObject
{
    Q_OBJECT

public:
//    QResult() {
//    }
//    virtual ~QResult(){
//    }
private:
    double RESULT;
    int ErrorCode;

private slots:
    void preDoit(int TypeWork, double OperandA, double OperandB){
        ErrorCode = 0;
        DoIt (TypeWork, OperandA, OperandB, ErrorCode);
    }

    double DoIt (int TypeWork, double OperandA, double OperandB, int &ErrorCode){

        double result = 0;
        if (OperandB == 0 && TypeWork == 4){

            ErrorCode = 1;
            RESULT = result;
//            emit sendValue(result);
            return result;
        }

        switch (TypeWork) {
        case 1:
//            qDebug() << "DoIt" << OperandA<<"+"<<OperandB;
            result = OperandA + OperandB;
            break;
        case 2:
//            qDebug() << "DoIt" << OperandA<<"-"<<OperandB;
            result = OperandA - OperandB;
            break;
        case 3:
//            qDebug() << "DoIt" << OperandA<<"*"<<OperandB;
            result = OperandA * OperandB;
            break;
        case 4:
//            qDebug() << "DoIt" << OperandA<<"/"<<OperandB;
            result = OperandA / OperandB;
            break;
            //        default:
            //            break;
        }

        RESULT = result;
//        emit sendValue(result);
        return result;
    }

    void getValueResultSlot(int row, int delay){
        sleep(delay);
        emit setValueResultInTerm(row, QString::number(RESULT), ErrorCode);
    }

    void sleep(int sec){
        static QMutex mutex;
        static QMutexLocker locker(&mutex);
        mutex.tryLock(sec * 1000);
    }

signals:
//    void sendValue(double);
//    void sendError(int, int);
    void setValueResultInTerm(int, QString, int);
};

#endif // QRESULT_H
