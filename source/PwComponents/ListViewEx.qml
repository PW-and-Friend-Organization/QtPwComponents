import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtGraphicalEffects 1.0
import "qrc:/ionicons"

ListView {
    id: mainListView
    anchors.fill: parent
    clip: true

    property alias label: label
    property int refreshPullDistance: 120
    property bool _dragVisible: false
    signal refresh()

    onDragEnded: {
        if (header.refresh) refresh()
        _dragVisible = false
    }
    onDragStarted: {
        _dragVisible = true
    }

    Item {
        id: header
        height: 60
        width: parent.width
        y: -mainListView.contentY + (label.height - height - 10) * _dragRatio

        property double _dragRatio: Math.min(1.0, Math.max(0, -mainListView.contentY / refreshPullDistance))
        property bool refresh: state == "pulled" ? true : false

        Rectangle {
            visible: row.visible
            anchors.fill: row
            anchors.leftMargin: -10
            anchors.rightMargin: -10
            radius: height / 2
            color: Material.background
            layer.enabled: true
            layer.effect: DropShadow {
                radius: 2
                samples: 12
                verticalOffset: 1
                color: Material.foreground
            }

        }

        Row {
            id: row
            spacing: 6
            height: childrenRect.height
            visible: header._dragRatio > 0.0 && _dragVisible
            anchors.centerIn: parent

            Ionicon {
                id: arrow
                source: "refresh"
                color: Material.foreground
                transformOrigin: Item.Center
                Behavior on rotation { NumberAnimation { duration: 500 } }
            }

            Label {
                id: label
                anchors.verticalCenter: arrow.verticalCenter
                text: "pull to refresh"
            }
        }

        states: [
            State {
                name: "base"; when: mainListView.contentY >= -refreshPullDistance
                PropertyChanges { target: arrow; rotation: 180 }
            },
            State {
                name: "pulled"; when: mainListView.contentY < -refreshPullDistance
                PropertyChanges { target: label; text: "release to refresh" }
                PropertyChanges { target: arrow; rotation: 0 }
            }
        ]
    }
}
