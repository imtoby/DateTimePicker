import QtQuick 2.3
import QtQuick.Window 2.2
import "qml"

Window {
    visible: true
    width: 360
    height: 220

//    TimePositioner{
//        anchors.fill: parent
//        anchors.margins: 40
//        model: 60 // 设置小时、分钟的个数
//        currentIndex: 0
//    }

    BasePicker {
        id: datePicker

        Component.onCompleted: {
            dataModelManager.initData();
        }

        Connections {
            target: dataModelManager
            ignoreUnknownSignals: true
            onDateModelInitFinished: {
                datePicker.model = Qt.binding(
                            function(){ return dataModelManager.dateModel();});
                datePicker.setCurrentIndex(
                            dataModelManager.dateModelInitIndex());
            }
        }
    }
}
