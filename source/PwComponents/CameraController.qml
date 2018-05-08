import QtQuick 2.9
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0
import "qrc:/ionicons"

Item {
    anchors.fill: parent

    property alias capture: mouseArea
    property alias preview: preview
    property alias slider: slider
    signal openImage(var imagePath)

    Rectangle {
        id: button
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        height: 80
        width: height
        radius: height / 2
        border.color: themeColor.primaryColor
        border.width: 3
        color: "transparent"

        Rectangle {
            anchors.centerIn: parent
            height: parent.height - 20
            width: height
            radius: height / 2
            color: themeColor.primaryColor
        }

        MouseArea {
            id: mouseArea
            anchors.fill: parent
        }

        states: State {
            name: "pressed"; when: mouseArea.pressed
            PropertyChanges { target: button; color: "#FFF" }
        }

        transitions: Transition { ColorAnimation { duration: 800 } }
    }

    DropShadow {
        anchors.fill: button
        horizontalOffset: 3
        verticalOffset: 3
        radius: 8.0
        samples: 17
        color: "#80FFFFFF"
        source: button
    }

    Image {
        id: preview
        anchors { left: parent.left; leftMargin: 20; verticalCenter: button.verticalCenter }
        width: 80; height: 80
        mirror: true
        fillMode: Image.PreserveAspectFit
        MouseArea {
            anchors.fill: parent
            onClicked: openImage(preview.source)
        }
    }

    Slider {
        id: slider
        height: parent.height * 3 / 4
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 10
        orientation: Qt.Vertical
    }
}
