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

        //������ � ������� ��������
        connect(this,       SIGNAL(setRequests(int, QString, int)),                        p_requests,  SLOT(setRequestsList(int, QString, int)));
        //����������
        connect(this,       SIGNAL(getResult(int, double, double)),                        &result,     SLOT(preDoit(int, double, double)));
        //���������� � ���������
        connect(this,       SIGNAL(getResultForTerm(int, int)),                             &result,    SLOT(getValueResultSlot(int, int)));
        //����� ���������� �� ����� ���������
        connect(&result,    SIGNAL(setValueResultInTerm(int, QString, int)),                this,       SLOT(setValueResult(int, QString, int)));
        //����� ��������, �� ����� ���������
        connect(p_requests, SIGNAL(setValueOperation(int, QString, QString, QString, int)), this,       SLOT(requestInTerm(int, QString, QString, QString, int)));
        //����� ����������� �� ����� ������������
//        connect(&result,    SIGNAL(sendValue(double)),                                      this,       SIGNAL(setResultDisplay(double)));

        p_requests->moveToThread(pth_requests);
        pth_requests->start();

        result.moveToThread(&th_result);
        th_result.start();
    }

//    ~AppCore(){
//    }

private:
    QThread *pth_requests;  // ����� �������
    QRequests *p_requests;

    QThread th_result;     // ����� ����������
    QResult result;

public slots:
    double stringToDouble(QString str){//������ � �����, ��� �������������� ��������
        if (str.contains("'>")){
            str = str.mid(str.indexOf(">")+1,str.indexOf("</",str.indexOf(">")+1 )-str.indexOf(">")-1);
        }
        return str.toDouble();
    }

    bool point(QString str){//�������� �� ��������� ������� "."
        return str.contains(".");
    }

    QString stringForBack(QString str){//������� ������ � �������
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

        emit setRequests(count, getOperation, Delay);//������ � �������
        emit getResult(TypeWork, OperandA, OperandB);//����������

    }

private slots:  

    //����� ��������, �� ����� ���������
    void requestInTerm(int _row, QString _operation, QString _results, QString _status, int _delay){
        emit setValueOperation(_row, _operation, _results, _status, _delay);
        emit getResultForTerm(_row, _delay);
    }

    //����� ���������� �� ����� ���������
    void setValueResult(int row, QString result, int ErrorCode){
        if (ErrorCode == 1)
            emit setResultTerm(row, "<font color='RED'>" + result + "</font>", "<font color='RED'>division by zero</font>");
        else
            emit setResultTerm(row, "<font color='BLUE'>" + result + "</font>", "<font color='LIME'>Done</font>");

    }

signals:
    void getResult          (int, double, double);//����������
    void getResultForTerm   (int _row, int _delay);//���������� � ���������
    void setRequests        (int, QString, int);//������ � �������
    void setValueOperation  (int _row, QString _operation = "", QString _results = "", QString _status = "", int _delay = 0);//����� ��������, �� ����� ���������
//    void setResultDisplay   (double resultDisplay);//����� ����������� �� ����� ������������
    void setResultTerm      (int _row, QString _results, QString _status);//����� ���������� �� ����� ���������


};

#endif // APPCORE_H
