import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.2

Button {
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
            if (result){
                textEdit.text = text
                result = false
            }
            else
                textEdit.text = textEdit.text + text

            operandB = appCore.stringToDouble(textEdit.text)
        }
        else{
            if (result){
                textEdit.text = text
                result = false
            }
            else
                textEdit.text = textEdit.text + text

            operandA = appCore.stringToDouble(textEdit.text)
        }
    }
}
