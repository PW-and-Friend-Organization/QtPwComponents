import QtQuick 2.9
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0

Item {
    property alias label: label
    property alias rect: rect
    property alias text: label.text
    property alias color: rect.color
    property alias textColor: label.color
    property alias size: label.font.pointSize

    width: rect.width
    height: rect.height

    Rectangle {
        id: rect
        anchors.fill: label
        color: themeColor.primaryColor
        radius: height / 2
        layer.enabled: true
        layer.effect: DropShadow {
            radius: 2
            samples: radius * 2
            verticalOffset: 1
            color: "grey"
        }
    }

    Label {
        id: label
        leftPadding: 10; rightPadding: 10; topPadding: 3; bottomPadding: 3
        color: "#FFF"
        font.weight: Font.Normal; font.pointSize: defaultPointSize
    }
}
