import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.2

    TableView {
        id: view

        anchors.margins: 10
        anchors.fill: parent
        model: dataModel
        clip: true

        TableViewColumn {
            width: 30
            title: "№"
            role: "row"
        }
        TableViewColumn {
            width: 80
            title: "Operation"
            role: "oper"
        }
        TableViewColumn {
            width: 80
            title: "Result"
            role: "result"

        }
        TableViewColumn {
            width: 100
            title: "Status"
            role: "status"
        }
        TableViewColumn {
            width: 50
            title: "Delay"
            role: "delay"
        }

    }


