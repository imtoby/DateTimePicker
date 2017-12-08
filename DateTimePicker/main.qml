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

//    Timer {
//        interval: 500
//        repeat: true
//        onTriggered: {
//            yearMonthDayPicker.month = (yearMonthDayPicker.month+1)%12;
//        }
//        running: true
//    }

    YearMonthDayPicker {
        id: yearMonthDayPicker
        month: 2
        day: 28
    }
}
