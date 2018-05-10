import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtGraphicalEffects 1.0
import "qrc:/ionicons"
import "." as AppComponent

Item {
    id: root
    anchors.fill: parent
    property bool expand: true

    property alias model: repeater.model
    property alias button: mainBtn
    signal subClicked(var model)

    Rectangle {
        id: rect
        color: Material.background
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
                    button.color: model.color || Material.accent
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
    Item {
        width: 56
        height: 56
        z: 1
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.margins: 20

        signal clicked()
        property alias ionicon: icon.source
        property alias icon: icon
        property alias mouseArea: mouseArea
        property alias button: button

        Rectangle {
            id: button
            anchors.fill: parent
            radius: width / 2
            color: Material.accent
        }

        Ionicon {
            id: icon
            z: 1
            anchors.centerIn: parent
            source: "plus-round"
            color: Material.background
        }

        MouseArea {
            id: mouseArea
            anchors.fill: button
            onClicked: expand = !expand
            onPressed: shadow.radius = 4.0
            onReleased: shadow.radius = 8.0
        }

        DropShadow {
            id: shadow
            anchors.fill: button
            verticalOffset: 3
            radius: 8.0
            samples: 16
            color: Material.foreground
            opacity: 0.5
            source: button

            Behavior on radius { NumberAnimation { duration: 300; easing.type: Easing.InCubic } }
        }
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
