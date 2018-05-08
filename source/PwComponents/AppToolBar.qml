import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import "qrc:/ionicons"
import "." as AppComponent

ToolBar {
    id: toolbar
    property alias title: title
    property alias text: title.text
    property alias button1: button1
    property alias button2: button2

    background: Rectangle { color: themeColor.backgroudColorLight }

    RowLayout {
        anchors.fill: parent
        spacing: 10

        ToolButton {
            contentItem: Ionicon { size: 20; source: stackView.depth > 1 ? "android-arrow-back" : "navicon-round" }
            onClicked: {
                if (stackView.depth > 1)
                    stackView.pop()
                else
                    drawer.open()
            }
        }
        Label {
            id: title
            Layout.fillWidth: true
            font.weight: Font.Medium
            color: "#000"
        }
        Row {
            ToolButton {
                id: button1
                visible: false
                width: 40
            }
            ToolButton {
                id: button2
                visible: false
                width: 40
            }
        }
    }
}
