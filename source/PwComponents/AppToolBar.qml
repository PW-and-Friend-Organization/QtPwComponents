import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.2
import "qrc:/ionicons"
import "." as AppComponent

ToolBar {
    id: toolbar
    property alias title: title.text
    property alias extendedAction: extendedAction
    RowLayout {
        anchors { left: parent.left; right: parent.right; verticalCenter: parent.verticalCenter }
        ToolButton {
            contentItem: Ionicon {
                color: Material.background
                source: stackView.depth > 1 ? "android-arrow-back" : "navicon-round"
            }
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
            leftPadding: 32
            font.weight: Font.Medium
            font.pointSize: defaultPointSize + 1
        }
        Row {
            id: extendedAction
        }
    }
}
