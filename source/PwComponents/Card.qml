import QtQuick 2.9
import QtQuick.Controls.Material 2.2
import QtGraphicalEffects 1.0

Item {
    property alias rect: rect

    RectangularGlow {
        anchors.fill: parent
        spread: 0.01
        glowRadius: 8
        color: Material.foreground
        opacity: 0.3
    }

    Rectangle {
        id: rect
        anchors.fill: parent
        radius: 2
        color: Material.background
    }
}
