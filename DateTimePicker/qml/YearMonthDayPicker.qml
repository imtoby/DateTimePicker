import QtQuick 2.3

Row {
    id: yearMonthDayPicker
    anchors.fill: parent
    objectName: "YearMonthDayPicker"

    property int maxYear: 2050
    property int minYear: 1970

    property int day: -1
    property int month: yearPicker.initDate.getMonth()
    property int year: yearPicker.initDate.getFullYear()

    property alias dayPickerWidth: dayPicker.width
    property alias monthPickerWidth: monthPicker.width
    property alias yearPickerWidth: yearPicker.width

    BasePicker {
        id: yearPicker

        property var initDate: new Date

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
        }
        function initYears() {
            var years = new Array;
            for (var i=minYear; i<=maxYear; ++i) {
                years.push(i);
            }
            model = years;
            i = years.indexOf(year);
            if (i > -1) {
                yearPicker.setCurrentIndex(i);
            }
        }
    }

    BasePicker {
        id: monthPicker
        implicitWidth: 60
        Component.onCompleted: {
            initMonths();
        }
        function initMonths() {
            var months = new Array;
            for (var i=1; i<=12; ++i) {
                months.push(i);
            }
            model = months;
            i = months.indexOf(month);
            if (i > -1) {
                monthPicker.setCurrentIndex(i);
            }
        }
    }

    BasePicker {
        id: dayPicker
        implicitWidth: 60
        model: 40
    }

    onMinYearChanged: {
        console.log(yearMonthDayPicker.objectName, "minYearChanged");
    }

    onMaxYearChanged: {
        console.log(yearMonthDayPicker.objectName, "maxYearChanged");
    }

}
