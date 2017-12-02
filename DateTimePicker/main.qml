import QtQuick 2.3
import QtQuick.Window 2.2
import "qml"

Window {
    visible: true
    width: 360
    height: 360

//    TimePositioner{
//        anchors.fill: parent
//        anchors.margins: 40
//        model: 60 // 设置小时、分钟的个数
//        currentIndex: 0
//    }

    BasePicker {
        model: 24
    }

}
