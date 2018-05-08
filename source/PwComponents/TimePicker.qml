// ekke (Ekkehard Gentz) @ekkescorner
import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

Popup {
    id: timePicker
    x: (parent.width - contentWidth) / 2
    y: (parent.height - contentHeight) / 2
    property date selectedTime: new Date()
    property bool hourView: true
    property int clockTextSize: defaultPointSize
    property alias clockFrame: frame

    property int hour
    property int minute
    property bool am
    signal doneClick(var date)

    leftPadding: 0
    rightPadding: 0
    topPadding: 0
    bottomPadding: 0
    modal: true

    onHourViewChanged: setClockUi()
    onSelectedTimeChanged: {
        hourView = true
        hour = selectedTime.getHours()
        minute = selectedTime.getMinutes()
        am = Math.floor(selectedTime.getHours() / 12) ? false : true
        setClockUi()
    }

    Component.onCompleted: setClockUi()

    Column {
        Rectangle {
            width: parent.width
            height: display.height
            color: themeColor.primaryColor
            Row {
                id: display
                anchors.right: parent.right
                anchors.rightMargin: 20
                topPadding: 20
                bottomPadding: 20
                spacing: 10
                Label {
                    id: hourLabel
                    text: hour
                    color: themeColor.inverseForegroundColor
                    font.pointSize: defaultPointSize + 4
                    font.bold: hourView
                    MouseArea {
                        anchors.fill: parent
                        onClicked: hourView = true
                    }
                }
                Label {
                    anchors.bottom: hourLabel.bottom
                    text: ":"
                    color: themeColor.inverseForegroundColor
                    font.pointSize: defaultPointSize + 4
                }
                Label {
                    anchors.bottom: hourLabel.bottom
                    text: minute < 10 ? "0" + minute : minute
                    color: themeColor.inverseForegroundColor
                    font.pointSize: defaultPointSize + 4
                    font.bold: !hourView
                    MouseArea {
                        anchors.fill: parent
                        onClicked: hourView = false
                    }
                }
                Label {
                    anchors.bottom: hourLabel.bottom
                    text: am ? "AM" : "PM"
                    color: themeColor.inverseForegroundColor
                    font.pointSize: defaultPointSize + 3
                    MouseArea {
                        anchors.fill: parent
                        onClicked: am = !am
                    }
                }
            }
        }

        Item {
            id: frame
            width: 250
            height: 250
            property int margins: 15
            property int center: width / 2
            property int offset: (width - margins * 2) / 2 - margins

            // 1.0472 = -60 degree so that 0 is start at 1 o clock
            // 0.523599 = step number 30 degress
            Repeater {
                model: 12
                Label {
                    x: computeX(index, contentWidth)
                    y: computeY(index, contentHeight)
                    text: hourView ? index + 1 : (index < 11 ? (index + 1) * 5 : 0)
                    font.pointSize: clockTextSize
                }
            }

            Rectangle {
                id: highlight
                radius: 20; width: 40; height: 40
                color: themeColor.primaryColor
                opacity: 0.4

                function setIndex(index) {
                    x = computeX(index - 1, width)
                    y = computeY(index - 1, height)
                }
            }

            MouseArea {
                anchors.fill: parent
                onMouseXChanged: frame.computeIndex(mouseX, mouseY)
                onReleased: {
                    if (hourView) hourView = false
                }
            }

            function computeIndex(mouseX, mouseY) {
                var degree90 = 1.5708
                var rad2deg = 57.2958
                var diffY = mouseY - height / 2
                var diffX = mouseX - width / 2
                var atan = Math.atan(diffY / diffX)

                var bearing
                if (diffX > 0) bearing = atan + degree90
                else bearing = degree90 * 3 + atan

                var bearingDeg = bearing * rad2deg
                var index = bearingDeg / 360 * 12
                if (hourView) {
                    highlight.x = computeX(Math.round(index) - 1, highlight.width)
                    highlight.y = computeY(Math.round(index) - 1, highlight.height)
                    hour = Math.round(index)
                }
                else {
                    highlight.x = computeX(index - 1, highlight.width)
                    highlight.y = computeY(index - 1, highlight.height)
                    minute = Math.floor(index * 5)
                }
            }
        }

        Row {
            anchors.right: parent.right
            anchors.rightMargin: 5
            Button {
                flat: true; highlighted: true
                text: "CANCEL"
                onClicked: timePicker.close()
            }

            Button {
                flat: true; highlighted: true
                text: "DONE"
                onClicked: {
                    var date = new Date()
                    var addHour = am ? 0 : 12
                    date.setHours(hour + addHour)
                    date.setMinutes(minute)
                    date.setSeconds(0)
                    doneClick(date)
                }
            }
        }
    }

    function computeX(index, contentWidth) {
        return (Math.cos(0.523599 * index - 1.0472) * frame.offset + frame.center) - contentWidth / 2
    }

    function computeY(index, contentHeight) {
        return (Math.sin(0.523599 * index - 1.0472) * frame.offset + frame.center) - contentHeight / 2
    }

    function setClockUi() {
        if (hour >= 12) hour -= 12
        if (hourView)
            highlight.setIndex(hour)
        else
            highlight.setIndex(minute / 5)
    }
}
