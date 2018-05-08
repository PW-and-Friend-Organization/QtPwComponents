import QtQuick 2.9
import QtGraphicalEffects 1.0

Item {
    property alias rect: rect

    RectangularGlow {
        anchors.fill: parent
        spread: 0.05
        glowRadius: 5
        color: "black"
    }

    Rectangle {
        id: rect
        anchors.fill: parent
        radius: 2
        color: "#FFFFFF"
    }
}
