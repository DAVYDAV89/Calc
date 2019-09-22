import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.2
import QtQuick.Controls.Styles 1.4


ApplicationWindow {
    id: app
    visible: true
    width: 750
    height: 500
    maximumHeight: height
    maximumWidth: width
    minimumHeight: height
    minimumWidth: width
    title: qsTr("Calculator")

    property int count: 0

    property int typeWork: 0
    property double operandA: 0
    property double operandB: 0
    property bool result: false

    property string operation: ""
    property string results: ""
    property string status: ""
    property int delay: spinBox.value



    Connections{
        target: appCore

        onSetValueOperation:{
            status = _status
            dataModel.insert(_row, {row: _row+1, oper: _operation, result: _results, status: _status, delay: _delay })
            //            console.log("row:", _row);
            //            console.log("oper:", _operation);
            //            console.log("result:", _results);
            //            console.log("status:", _status);
            //            console.log("delay:", _delay);
        }
        onSetResultTerm:{
            dataModel.set ( _row, {result: _results, status: _status} )
            textEdit.text = _results
            operandA = appCore.stringToDouble(_results)
        }
    }

    RowLayout {
        id: rowLayout3

        anchors.fill: parent
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top:  parent.bottom
        anchors.topMargin: 5
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5

        GridLayout {
            id: gridButton
            width: 335
            Layout.minimumWidth: 335

            Layout.fillWidth:  true
            Layout.fillHeight: true

            Rectangle{
                id: display

                Layout.row: 0
                Layout.column: 0
                Layout.rowSpan: 1
                Layout.columnSpan: 4
                Layout.fillWidth: true
                Layout.fillHeight:  true

                height: 60
                border.color: "gray"
                color: "#cccccc"
                radius: 15


                Text {
                    id: textEdit
                    elide: Text.ElideLeft
                    x: 8
                    y: 16
                    text: qsTr("")
                    font.bold: true
                    font.pixelSize: 40
                    color: "#f22828"

                    width: 315
                    height: 55

                    anchors.right: parent.right
                    anchors.rightMargin: 7

                    fontSizeMode: Text.FixedSize
                    verticalAlignment: Text.AlignBottom
                    horizontalAlignment: Text.AlignRight
                }
            }

            CalcButton{
                text: "7"
                Layout.fillWidth: true
                Layout.row: 1
                Layout.column: 0
            }
            CalcButton{
                text: "8"
                Layout.fillWidth: true
                Layout.row: 1
                Layout.column: 1

            }
            CalcButton{
                text: "9"
                Layout.fillWidth: true
                Layout.row: 1
                Layout.column: 2

            }
            Button {
                text: "+"
                Layout.fillWidth: true
                Layout.row: 1
                Layout.column: 3
                Layout.fillHeight:  true
                Layout.minimumWidth: 88

                font.pointSize: 15
                background: Rectangle {
                    color: parent.down ? "#d7d7d7" : "#f7f7f7"
                    border.color: "#26282a"
                    border.width: 2
                    radius: 15
                }
                onClicked: {
                    if (typeWork > 0 ){
                        delay = spinBox.value
                        appCore.whatDoIt(count,typeWork,operandA,operandB,delay)
//                        operandA = textEdit.text
                        result = true
                        typeWork = 1
                        count++
                    }

                    else{
                        typeWork = 1
                        textEdit.text = ""
                    }
                }
            }

            CalcButton{
                text: "4"
                Layout.fillWidth: true
                Layout.row: 2
                Layout.column: 0

            }
            CalcButton{
                text: "5"
                Layout.fillWidth: true
                Layout.row: 2
                Layout.column: 1

            }
            CalcButton{
                text: "6"
                Layout.fillWidth: true
                Layout.row: 2
                Layout.column: 2

            }
            Button {
                text: "-"
                Layout.fillWidth: true
                Layout.row: 2
                Layout.column: 3
                Layout.fillHeight:  true
                Layout.minimumWidth: 88

                font.pointSize: 15
                background: Rectangle {
                    color: parent.down ? "#d7d7d7" : "#f7f7f7"
                    border.color: "#26282a"
                    border.width: 2
                    radius: 15
                }
                onClicked: {
                    if (typeWork > 0 ){
                        delay = spinBox.value
                        appCore.whatDoIt(count,typeWork,operandA,operandB,delay)
//                        operandA = textEdit.text
                        result = true
                        typeWork = 2
                        count++
                    }

                    else{
                        typeWork = 2
                        textEdit.text = ""
                    }
                }
            }

            CalcButton{
                text: "1"
                Layout.fillWidth: true
                Layout.row: 3
                Layout.column: 0

            }
            CalcButton{
                text: "2"
                Layout.fillWidth: true
                Layout.row: 3
                Layout.column: 1

            }
            CalcButton{
                text: "3"
                Layout.fillWidth: true
                Layout.row: 3
                Layout.column: 2

            }
            Button {
                text: "*"
                Layout.fillWidth: true
                Layout.row: 3
                Layout.column: 3
                Layout.fillHeight:  true
                width: 88
                Layout.minimumWidth: 88

                font.pointSize: 15
                background: Rectangle {
                    color: parent.down ? "#d7d7d7" : "#f7f7f7"
                    border.color: "#26282a"
                    border.width: 2
                    radius: 15
                }
                onClicked: {
                    if (typeWork > 0 ){
                        delay = spinBox.value
                        appCore.whatDoIt(count,typeWork,operandA,operandB,delay)
//                        operandA = textEdit.text
                        result = true
                        typeWork = 3
                        count++
                    }

                    else{
                        typeWork = 3
                        textEdit.text = ""
                    }
                }
            }
            Button {
                text: "Back"
                Layout.minimumWidth: 87
                Layout.row: 4
                Layout.column: 0
                Layout.fillWidth: true
                Layout.fillHeight:  true
                font.pointSize: 15
                background: Rectangle {
                    color: parent.down ? "#d7d7d7" : "#f7f7f7"
                    border.color: "#26282a"
                    border.width: 2
                    radius: 15
                }
                onClicked: {
                    textEdit.text = appCore.stringForBack(textEdit.text)
                }
            }

            CalcButton{
                text: "0"
                Layout.fillWidth: true
                Layout.row: 4
                Layout.column: 1

            }
            //            CalcButton{
            //                text: "."
            //                Layout.row: 4
            //                Layout.column: 2
            //            }
            Button {
                text: "."
                Layout.fillWidth: true
                Layout.row: 4
                Layout.column: 2
                Layout.fillHeight:  true

                width: 88
                Layout.minimumWidth: 88

                font.pointSize: 15
                background: Rectangle {
                    color: parent.down ? "#d7d7d7" : "#f7f7f7"
                    border.color: "#26282a"
                    border.width: 2
                    radius: 15
                }
                onClicked: {
                    if(!appCore.point(textEdit.text))
                        textEdit.text = textEdit.text + text

                }
            }


            Button {
                text: "/"
                Layout.fillWidth: true
                Layout.row: 4
                Layout.column: 3
                Layout.fillHeight:  true
                width: 88
                Layout.minimumWidth: 88

                font.pointSize: 15
                background: Rectangle {
                    color: parent.down ? "#d7d7d7" : "#f7f7f7"
                    border.color: "#26282a"
                    border.width: 2
                    radius: 15
                }

                onClicked: {
                    if (typeWork > 0 ){
                        delay = spinBox.value
                        appCore.whatDoIt(count,typeWork,operandA,operandB,delay)
//                        operandA = textEdit.text
                        result = true
                        typeWork = 4
                        count++
                    }

                    else{
                        typeWork = 4
                        textEdit.text = ""
                    }
                }
            }
            Button {
                text: "C"
                Layout.row: 5
                Layout.column: 0
                Layout.rowSpan: 1
                Layout.columnSpan: 2
                Layout.fillWidth: true
                Layout.fillHeight:  true
                font.pointSize: 15
                background: Rectangle {
                    color: parent.down ? "#d7d7d7" : "#f7f7f7"
                    border.color: "#26282a"
                    border.width: 2
                    radius: 15
                }
                onClicked: {
                    textEdit.text = ""
                    operandA = 0
                    operandB = 0
                    typeWork = 0
                }
            }

            Button {
                text: "="
                Layout.row: 5
                Layout.column: 2
                Layout.rowSpan: 1
                Layout.columnSpan: 2
                Layout.fillWidth: true
                Layout.fillHeight:  true
                font.pointSize: 15
                background: Rectangle {
                    color: parent.down ? "#f7f7f7" : "#d7d7d7"
                    border.color: "#26282a"
                    border.width: 2
                    radius: 15
                }
                onClicked: {
                    if (!(operandA == 0 && operandB == 0)){
                        delay = spinBox.value
                        appCore.whatDoIt(count,typeWork,operandA,operandB,delay)
                        result = true
                        typeWork = 0
                        operandB = 0
                        count++
                    }
                }
            }

            Label {
                id: label
                text: qsTr("\nDelay:")
                Layout.row: 6
                Layout.column: 0
                Layout.rowSpan: 1
                Layout.columnSpan: 2
                Layout.fillWidth: true
                Layout.fillHeight:  true
                font.pointSize: 15
            }
            SpinBox {
                id: spinBox
                from: 0
                to: 99
                stepSize: 1
                editable: true

                Layout.row: 6
                Layout.column: 2
                Layout.rowSpan: 1
                Layout.columnSpan: 2
            }

        }

        GridLayout {
            id: gridTerm
            width: 340
            Layout.minimumWidth: 340

            Rectangle {
                id: term
                width: 360
                height: 360

                border.color: "gray"
                color: "#cccccc"
                radius: 15
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Layout.fillWidth: true
                Layout.fillHeight:  true

                ListModel {
                    id: dataModel
                }
                Term{
                    id: termDisplay
                }
            }
        }
    }
}
