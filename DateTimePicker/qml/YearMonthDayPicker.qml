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

    BasePicker {
        id: yearPicker

        property var initDate: new Date
        property bool userOperated: false

        implicitWidth: 120
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
    }

    BasePicker {
        id: dayPicker
        implicitWidth: 60
        property bool userOperated: false
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
            var monthDays = new Date(year, month, 0);
            var days = new Array;
            var n = monthDays.getDate();
            for (var i=1; i<=n; ++i) {
                days.push(i);
            }
            model = days;
            i = days.indexOf(day);
            if (i > -1) {
                setCurrentIndex(i);
            }
        }
    }

    onMinYearChanged: {
        yearPicker.initYears();
    }

    onMaxYearChanged: {
        yearPicker.initYears();
    }

    onYearChanged: {
        if (!yearPicker.userOperated) {
            dayPicker.initDays();
            yearPicker.setCurrentIndex(year - minYear);
        }
        yearPicker.userOperated = false;
    }

    onMonthChanged: {
        if (!monthPicker.userOperated) {
            dayPicker.initDays();
            monthPicker.setCurrentIndex(month - 1);
        }
        monthPicker.userOperated = false;
    }

    onDayChanged: {
        if (!dayPicker.userOperated) {
            dayPicker.setCurrentIndex(day - 1);
        }
        dayPicker.userOperated = false;
    }
}
