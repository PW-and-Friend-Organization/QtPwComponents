import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import "qrc:/ionicons"

ItemDelegate {
    anchors.left: parent.left
    anchors.right: parent.right
    height: visible ? content.height + 10 : 0

    property bool divider: true
    property alias ionicon: icon.source
    property alias title: title
    property alias desc: desc
    property alias subDesc: subDesc
    property alias flow: flow
    property alias mouseArea: mouseArea

    RowLayout {
        id: content
        width: parent.width
        anchors.verticalCenter: parent.verticalCenter
        spacing: 20
        Ionicon {
            id: icon
            leftPadding: 10; anchors.top: parent.top; Layout.preferredWidth: 40
            source: "person"; size: 40; color: themeColor.backgroudColorShade
        }
        Column {
            Layout.fillWidth: true
            bottomPadding: 3
            spacing: 3
            Label {
                id: title
                font.weight: Font.Normal
                wrapMode: Label.WordWrap; width: parent.width; visible: text !== ""
            }
            Label {
                id: desc
                font.weight: Font.Light; font.pointSize: defaultPointSize - 1
                wrapMode: Label.WordWrap; width: parent.width; visible: text !== ""
            }
            Label {
                id: subDesc
                font.weight: Font.Light; font.pointSize: defaultPointSize - 1
                wrapMode: Label.WordWrap; width: parent.width; visible: text !== ""
            }
            Flow { id: flow; width: parent.width; spacing: 5 }
        }
    }

    Rectangle {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: 1
        visible: divider
        color: themeColor.backgroudColorShade
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
    }
}
