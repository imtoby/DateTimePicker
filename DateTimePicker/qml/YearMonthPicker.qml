import QtQuick 2.3

Item {
    id: yearMonthPicker
    objectName: "yearMonthPicker"

    property int maxYear: 2050
    property int minYear: 1970

    property int month: yearPicker.initDate.getMonth() + 1
    property int year: yearPicker.initDate.getFullYear()

    property alias monthPickerWidth: monthPicker.width
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

    BasePicker {
        id: monthPicker
        implicitWidth: 60
        anchors.left: yearPicker.right
        property bool userOperated: false
        Component.onCompleted: {
            initMonths();
        }
        onFlickEnded: {
            setCurrentMonth();
        }
        onClicked: {
            setCurrentMonth();
        }
        function setCurrentMonth() {
            userOperated = true;
            var newMonth = 1 + currentIndex;
            if (newMonth !== month) {
                month = newMonth;
            }
        }
        function initMonths() {
            var months = new Array;
            for (var i=1; i<=12; ++i) {
                months.push(i);
            }
            model = months;
            i = months.indexOf(month);
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
        var newMonth = Math.min(Math.max(1, month), 12);
        if (!monthPicker.userOperated) {
            monthPicker.setCurrentIndex(newMonth - 1);
        }
        monthPicker.userOperated = false;
    }
}
