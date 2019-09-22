#ifndef APPCORE_H
#define APPCORE_H

#include <QThread>

#include "QRequests.h"
#include "QResult.h"

class AppCore : public QObject
{
    Q_OBJECT

public:   
    AppCore(){
        pth_requests = new QThread();
        p_requests = new QRequests();

        //Запись в очередь операции
        connect(this,       SIGNAL(setRequests(int, QString, int)),                        p_requests,  SLOT(setRequestsList(int, QString, int)));
        //Вычисления
        connect(this,       SIGNAL(getResult(int, double, double)),                        &result,     SLOT(preDoit(int, double, double)));
        //Вычисления с задержкой
        connect(this,       SIGNAL(getResultForTerm(int, int)),                             &result,    SLOT(getValueResultSlot(int, int)));
        //Вывод результата на экран терминала
        connect(&result,    SIGNAL(setValueResultInTerm(int, QString, int)),                this,       SLOT(setValueResult(int, QString, int)));
        //Вывод операции, на экран терминала
        connect(p_requests, SIGNAL(setValueOperation(int, QString, QString, QString, int)), this,       SLOT(requestInTerm(int, QString, QString, QString, int)));
        //Вывод результатов на экран калькулятора
//        connect(&result,    SIGNAL(sendValue(double)),                                      this,       SIGNAL(setResultDisplay(double)));

        p_requests->moveToThread(pth_requests);
        pth_requests->start();

        result.moveToThread(&th_result);
        th_result.start();
    }

//    ~AppCore(){
//    }

private:
    QThread *pth_requests;  // Поток очереди
    QRequests *p_requests;

    QThread th_result;     // Поток вычислений
    QResult result;

public slots:
    double stringToDouble(QString str){//строку в число, для математических операций
        if (str.contains("'>")){
            str = str.mid(str.indexOf(">")+1,str.indexOf("</",str.indexOf(">")+1 )-str.indexOf(">")-1);
        }
        return str.toDouble();
    }

    bool point(QString str){//проверка на повторное нажатие "."
        return str.contains(".");
    }

    QString stringForBack(QString str){//Удалить символ с дисплея
        return str.mid(0,str.length()-1);
    }

    void whatDoIt (int count, int TypeWork, double OperandA, double OperandB, int Delay){
        auto setOperation = [](int TypeWork, double OperandA, double OperandB)->QString{
                QString operation;
                switch (TypeWork) {
                case 1:
                    operation = QString::number(OperandA) + "+" + QString::number(OperandB);
                    break;
                case 2:
                    operation = QString::number(OperandA) + "-" + QString::number(OperandB);
                    break;
                case 3:
                    operation = QString::number(OperandA) + "*" + QString::number(OperandB);
                    break;
                case 4:
                    operation = QString::number(OperandA) + "/" + QString::number(OperandB);
                    break;
                    //        default:
                    //            break;
                }
                return operation;
        };
        auto getOperation = setOperation(TypeWork, OperandA, OperandB);

        emit setRequests(count, getOperation, Delay);//Запись в очередь
        emit getResult(TypeWork, OperandA, OperandB);//Вычисления

    }

private slots:  

    //Вывод операции, на экран терминала
    void requestInTerm(int _row, QString _operation, QString _results, QString _status, int _delay){
        emit setValueOperation(_row, _operation, _results, _status, _delay);
        emit getResultForTerm(_row, _delay);
    }

    //Вывод результата на экран терминала
    void setValueResult(int row, QString result, int ErrorCode){
        if (ErrorCode == 1)
            emit setResultTerm(row, "<font color='RED'>" + result + "</font>", "<font color='RED'>division by zero</font>");
        else
            emit setResultTerm(row, "<font color='BLUE'>" + result + "</font>", "<font color='LIME'>Done</font>");

    }

signals:
    void getResult          (int, double, double);//Вычисления
    void getResultForTerm   (int _row, int _delay);//Вычисления с задержкой
    void setRequests        (int, QString, int);//Запись в очередь
    void setValueOperation  (int _row, QString _operation = "", QString _results = "", QString _status = "", int _delay = 0);//Вывод операции, на экран терминала
//    void setResultDisplay   (double resultDisplay);//Вывод результатов на экран калькулятора
    void setResultTerm      (int _row, QString _results, QString _status);//Вывод результата на экран терминала


};

#endif // APPCORE_H
