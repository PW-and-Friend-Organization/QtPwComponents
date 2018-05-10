import QtQuick 2.9
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0
import QtQuick.Controls.Material 2.2

Item {
    property alias label: label
    property alias rect: rect
    property alias text: label.text
    property alias color: rect.color
    property alias textColor: label.color
    property alias pointSize: label.font.pointSize

    width: rect.width
    height: rect.height

    Rectangle {
        id: rect
        anchors.fill: label
        color: Material.accent
        radius: height / 2
        layer.enabled: true
        layer.effect: DropShadow {
            radius: 2
            samples: radius * 2
            verticalOffset: 1
            color: Material.foreground
            opacity: 0.8
        }
    }

    Label {
        id: label
        leftPadding: 8; rightPadding: 8; topPadding: 2; bottomPadding: 2
        color: Material.background
        font.weight: Font.Normal; font.pointSize: defaultPointSize
    }
}
