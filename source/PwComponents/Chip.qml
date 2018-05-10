import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import "qrc:/ionicons"

Item {
    id: root
    signal clicked
    signal actionClicked
    property alias text: label.text
    property alias color: rect.color
    property alias iconText: icon.source
    property alias actionText: action.source
    property alias pointSize: label.font.pointSize

    property alias rect: rect
    property alias label: label
    property alias icon: icon
    property alias action: action

    width: rect.width
    height: rect.height

    Rectangle {
        id: rect
        anchors.fill: row
        color: Material.accent
        radius: height / 2
    }

    MouseArea {
        anchors.fill: row
        onPressed: label.font.pointSize++
        onReleased: label.font.pointSize--
        onClicked: root.clicked()
    }

    Row {
        id: row
        leftPadding: 8; rightPadding: 8; topPadding: 2; bottomPadding: 2
        spacing: 8
        Ionicon {
            id: icon
            anchors.verticalCenter: parent.verticalCenter
            source: "heart"
            color: label.color
            size: label.implicitHeight
        }
        Label {
            id: label
            anchors.verticalCenter: parent.verticalCenter
            color: Material.background
            font.weight: Font.Normal; font.pointSize: defaultPointSize
        }
        Ionicon {
            id: action
            visible: source !== ""
            anchors.verticalCenter: parent.verticalCenter
//            source: "close-circled"
            color: label.color
            size: label.implicitHeight

            MouseArea {
                anchors.fill: parent
                anchors.margins: -8
                onPressed: action.size += 4
                onReleased: action.size -= 4
                onClicked: actionClicked()
            }
        }
    }
}
