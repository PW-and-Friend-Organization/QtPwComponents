import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import Qt.labs.calendar 1.0
import "qrc:/ionicons"

Popup {
    id: datePickerRoot
    x: (parent.width - contentWidth) / 2
    y: (parent.height - contentHeight) / 2
    property date selectedDate: new Date()
    property alias grid: grid
    signal dateClicked(var date)

    bottomPadding: 0
    topPadding: 0
    leftPadding: 0
    rightPadding: 0
    modal: true

    property var month: [
        "Jan", "Feb", "Mar", "Apr",
        "May", "Jun", "Jul", "Aug",
        "Sep", "Oct", "Nov", "Dec"
    ]

    Column {
        id: column
        spacing: 10

        Label {
            width: parent.width
            background: Rectangle { color: themeColor.primaryColor }
            color: themeColor.inverseForegroundColor
            padding: 20
            font.pointSize: defaultPointSize + 3
            text: selectedDate.toLocaleDateString()
        }
        RowLayout {
            width: parent.width
            Button {
                flat: true
                contentItem: Ionicon { source: "chevron-left"; size: 20 }
                onClicked: {
                    if (grid.month === 0) {
                        grid.year--
                        grid.month = 11
                    }
                    else
                        grid.month--
                }
            }
            Label {
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
                font.weight: Font.Bold
                font.pointSize: defaultPointSize + 1
                text: month[grid.month] + " " + grid.year
            }
            Button {
                flat: true
                contentItem: Ionicon { source: "chevron-right"; size: 20 }
                onClicked: {
                    if (grid.month === 11) {
                        grid.year++
                        grid.month = 0
                    }
                    else
                        grid.month++
                }
            }
        }
        DayOfWeekRow {
            leftPadding: 10
            rightPadding: 10
            width: parent.width
            delegate: Label {
                text: model.shortName
                font.bold: true
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }
        MonthGrid {
            id: grid
            Layout.fillWidth: true
            Layout.fillHeight: true
            leftPadding: 10
            rightPadding: 10
            bottomPadding: 10
            month: selectedDate.getMonth()
            year: selectedDate.getFullYear()
            delegate: ItemDelegate {
                height: 20
                background: Rectangle {
                    radius: parent.width / 2
                    color: isSelected(model) ? themeColor.primaryColor: "transparent"
                }

                Label {
                    anchors.centerIn: parent
                    opacity: model.month === grid.month ? 1 : 0.5
                    text: model.day
                    color: isSelected(model) ? "#FFF" : "#000"
                    font.weight: model.today ? Font.Bold : Font.Light
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: selectedDate = model.date
                }

                function isSelected(model) {
                    if (selectedDate.getDate() === model.day &&
                        selectedDate.getMonth() === model.month &&
                        selectedDate.getFullYear() === model.year)
                        return true
                    return false
                }
            }
        }

        Row {
            anchors.right: parent.right
            Button {
                flat: true; highlighted: true
                text: "CANCEL"
                onClicked: datePickerRoot.close()
            }

            Button {
                flat: true; highlighted: true
                text: "DONE"
                onClicked: {
                    datePickerRoot.close()
                    dateClicked(selectedDate)
                }
            }
        }

    }
}
