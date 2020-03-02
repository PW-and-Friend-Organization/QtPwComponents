import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import "." as AppComponent

Popup {
    id: popup

    property alias title: title
    property alias desc: desc
    signal confirm()
    signal cancel()

    Material.theme: parent.Material.theme
    x: (parent.width - contentWidth) / 2 - 10
    y: (parent.height - contentHeight) / 2 - 10
    padding: 10

    contentWidth: parent.width - 100 //listView.contentWidth
    contentHeight: column.height
    modal: true

    Column {
        id: column
        spacing: 10
        width: parent.width
        Label {
            id: title
            width: parent.width
            wrapMode: Text.WordWrap
            font.weight: Font.Normal; font.pointSize: defaultPointSize + 6
            // text: title
        }
        Label {
            id: desc
            font.weight: Font.Thin; font.pointSize: defaultPointSize + 3
            width: parent.width
            wrapMode: Text.WordWrap
            // text: desc
        }
        Row {
            anchors.right: parent.right
            spacing: 5
            AppComponent.IconButton {
                highlighted: true
                Material.background: Material.Red
                source: "close"
                onClicked: cancel()
            }
            AppComponent.IconButton {
                highlighted: true
                Material.background: Material.Green
                source: "checkmark"
                onClicked: confirm()
            }
        }
    }
}
