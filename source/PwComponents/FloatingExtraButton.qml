import QtQuick 2.9
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0
import "qrc:/ionicons"
import "." as AppComponent

Item {
    id: root
    anchors.fill: parent
    property bool expand: false

    property alias model: repeater.model
    property alias button: mainBtn
    signal subClicked(var model)

    Rectangle {
        id: rect
        color: themeColor.inverseForegroundColor
        opacity: 0.9
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        Behavior on height { NumberAnimation { duration: 300; easing.type: Easing.InCubic } }
        Behavior on width { NumberAnimation { duration: 300; easing.type: Easing.InCubic } }

        MouseArea {
            anchors.fill: parent
            onClicked: expand = false
        }
    }

    Column {
        visible: expand
        spacing: 15
        anchors.right: mainBtn.horizontalCenter
        anchors.rightMargin: -20
        anchors.bottom: mainBtn.top
        anchors.bottomMargin: 15

        Repeater {
            id: repeater
            Row {
                spacing: 15
                anchors.right: parent.right
                layoutDirection: Qt.RightToLeft
                AppComponent.FloatingActionButton {
                    width: 40; height: 40
                    anchors.bottom: undefined
                    anchors.right: undefined
                    icon.source: model.ionicon
                    icon.size: 20
                    button.color: model.color || themeColor.primaryColor
                    mouseArea.onClicked: {
                        expand = false
                        subClicked(model)
                    }
                }
                Label {
                    anchors.verticalCenter: parent.verticalCenter
                    font.weight: Font.Normal; font.pointSize: defaultPointSize + 3
                    text: model.name
                }
            }
        }
    }

    AppComponent.FloatingActionButton {
        id: mainBtn
        mouseArea.onClicked: expand = !expand
    }

    states: [
        State {
            name: "expand"; when: expand
            PropertyChanges { target: rect; width: root.width; height: root.height }
        },
        State {
            name: "collapse"; when: !expand
            PropertyChanges { target: rect; width: 0; height: 0 }
        }
    ]
}
