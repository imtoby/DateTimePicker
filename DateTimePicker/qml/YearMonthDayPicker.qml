import QtQuick 2.3

Row {
    id: yearMonthDayPicker
    anchors.fill: parent
    objectName: "YearMonthDayPicker"

    property int maxYear: 2050
    property int minYear: 1970

    property int day: yearPicker.initDate.getDate()
    property int month: yearPicker.initDate.getMonth() + 1
    property int year: yearPicker.initDate.getFullYear()

    property alias dayPickerWidth: dayPicker.width
    property alias monthPickerWidth: monthPicker.width
    property alias yearPickerWidth: yearPicker.width
    property var maximumDate: new Date(maxYear, 12, 31)
    property var minimumDate: new Date(minYear, 1, 1)

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
            dayPicker.initDays();
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
            dayPicker.initDays();
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

    BasePicker {
        id: dayPicker
        implicitWidth: 100
        property bool userOperated: false
        property var locale: Qt.locale("zh_CN")
        Component.onCompleted: {
            initDays();
        }
        onFlickEnded: {
            setCurrentDay();
        }
        onClicked: {
            setCurrentDay();
        }
        function setCurrentDay() {
            userOperated = true;
            var newDay = 1 + currentIndex;
            if (newDay !== day) {
                day = newDay;
            }
        }
        function initDays() {
            var monthDays = new Date(year, month - 1, 0);
            var days = new Array;
            var n = monthDays.getDate();
            var newDay = null;
            for (var i=1; i<=n; ++i) {
                newDay = new Date(year, month - 1, i);
                days.push(i + " " + newDay.toLocaleDateString(locale, "ddd"));
            }
            model = days;
            i = days.indexOf(day);
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
            dayPicker.initDays();
            yearPicker.setCurrentIndex(newYear - minYear);
        }
        yearPicker.userOperated = false;
    }

    onMonthChanged: {
        var newMonth = Math.min(Math.max(1, month), 12);
        if (!monthPicker.userOperated) {
            dayPicker.initDays();
            monthPicker.setCurrentIndex(newMonth - 1);
        }
        monthPicker.userOperated = false;
    }

    onDayChanged: {
        var maxDays = new Date(year, month - 1, 0).getDate();
        var newDay = Math.min(Math.max(1, day), maxDays);
        if (!dayPicker.userOperated) {
            dayPicker.setCurrentIndex(newDay - 1);
        }
        dayPicker.userOperated = false;
    }
}
