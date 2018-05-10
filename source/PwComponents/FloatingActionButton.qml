import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtGraphicalEffects 1.0
import "qrc:/ionicons"

Item {
    id: root
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
        onClicked: root.clicked()
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
