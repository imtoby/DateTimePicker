import QtQuick 2.3

BasePicker {
    id: datePicker
    objectName: "DatePicker"
    clip: true
    Component.onCompleted: {
        dataModelManager.initData();
    }

    Connections {
        target: dataModelManager
        ignoreUnknownSignals: true
        onDataModelInitFinished: {
            datePicker.model = Qt.binding(
                        function(){ return dataModelManager.dateModel();});
            datePicker.setCurrentIndex(
                        dataModelManager.dateModelInitIndex());
        }
    }

//    Rectangle {
//        anchors.fill: parent
//        color: "transparent"
//        border.color: "red"
//    }
}
