import QtQuick 2.3

BasePicker {
    id: monthPicker
    clip: true
    Component.onCompleted: {
        dataModelManager.initData();
    }

    Connections {
        target: dataModelManager
        ignoreUnknownSignals: true
        onDataModelInitFinished: {
            monthPicker.model = Qt.binding(
                        function(){ return dataModelManager.monthModel();});
            monthPicker.setCurrentIndex(
                        dataModelManager.monthModelInitIndex());
        }
    }

//    Rectangle {
//        anchors.fill: parent
//        color: "transparent"
//        border.color: "red"
//    }
}
