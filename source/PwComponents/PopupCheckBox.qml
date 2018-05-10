import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import "." as AppComponent

Popup {
    id: popup
    property alias model: listView.model
    property var selected: []
    property string title: ""
    signal itemChecked(var modelData)

    Material.theme: parent.Material.theme
    x: (parent.width - contentWidth) / 2 - 10
    y: (parent.height - contentHeight) / 2 - 10
    leftPadding: 0
    rightPadding: 0
    topPadding: 0
    bottomPadding: 0

    contentWidth: parent.width - 100 //listView.contentWidth
    contentHeight: Math.min(listView.contentHeight, parent.height - 100)
    modal: true

    ListView {
        id: listView
        clip: true
        width: popup.contentWidth
        height: popup.contentHeight
        boundsBehavior: Flickable.StopAtBounds
        header: Label {
            width: parent.width; height: contentHeight + 20
            text: title
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.weight: Font.Medium
            font.pointSize: defaultPointSize + 2
        }
        delegate: CheckDelegate {
            width: parent.width
            font.weight: Font.Light
            font.pointSize: defaultPointSize + 1
            text: modelData
            checked: selected.indexOf(modelData) !== -1
            onCheckedChanged: {
                if (checked === false) {
                    var index = selected.indexOf(modelData)
                    if (index > -1) selected.splice(index, 1)
                }
                else
                    selected.push(modelData)
                itemChecked(modelData)
            }
        }
    }
}
