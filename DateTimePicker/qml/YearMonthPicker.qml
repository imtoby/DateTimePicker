import QtQuick 2.3

Item {
    id: yearMonthPicker
    objectName: "yearMonthPicker"

    property int maxYear: 2050
    property int minYear: 1970

    property int year: yearPicker.initDate.getFullYear()
    property int month: yearPicker.initDate.getMonth() + 1

    property alias yearPickerWidth: yearPicker.width

    BasePicker {
        id: yearPicker

        property var initDate: new Date
        property bool userOperated: false

        implicitWidth: 90
        Component.onCompleted: {
            initYears();
        }
        onFlickEnded: {
            setCurrentYear();
        }
        onClicked: {
            setCurrentYear();
        }
        function setCurrentYear() {
            var newYear = minYear + currentIndex;
            if (newYear !== year) {
                year = newYear;
            }
        }
        function initYears() {
            userOperated = true;
            var years = new Array;
            for (var i=minYear; i<=maxYear; ++i) {
                years.push(i);
            }
            model = years;
            i = years.indexOf(year);
            if (i > -1) {
                setCurrentIndex(i);
            }
        }

//        Rectangle {
//            anchors.fill: parent
//            color: "transparent"
//            border.color: "red"
//        }
    }

    TimePositioner {
        id: timePositioner
        property bool userOperated: false

        width: Math.min(parent.width - yearPicker.width, parent.height) - 60
        height: width
        anchors.right: parent.right
        anchors.rightMargin: 60
        anchors.verticalCenter: parent.verticalCenter
        currentIndex: month%12
        onCurrentIndexChanged: {
            timePositioner.userOperated = true;
            month = currentIndex ? currentIndex : currentIndex + timePositioner.count
            timePositioner.userOperated = false;
        }
    }

    onMinYearChanged: {
        yearPicker.initYears();
    }

    onMaxYearChanged: {
        yearPicker.initYears();
    }

    onYearChanged: {
        var newYear = Math.min(Math.max(minYear, year), maxYear);
        if (!yearPicker.userOperated) {
            yearPicker.setCurrentIndex(newYear - minYear);
        }
        yearPicker.userOperated = false;
    }

    onMonthChanged: {
        if (!timePositioner.userOperated) {
            timePositioner.currentIndex = month%12
        }
    }
}
