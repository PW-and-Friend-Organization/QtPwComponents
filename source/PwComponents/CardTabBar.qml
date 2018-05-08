import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

Item {
    property alias model: repeater.model
    property int currentIndex: 0
    property color highlightColor: themeColor.primaryColor

    height: content.height
    RowLayout {
        id: content
        anchors.left: parent.left
        anchors.right: parent.right

        Repeater {
            id: repeater
            Column {
                Layout.preferredWidth: parent.width / repeater.count
                spacing: 5
                Label {
                    width: parent.width
                    horizontalAlignment: Text.AlignHCenter
                    font.weight: Font.Medium; font.pointSize: defaultPointSize + 1
                    color: currentIndex == index ? highlightColor : "black"
                    text: modelData
                    MouseArea {
                        anchors.fill: parent
                        onClicked: currentIndex = index
                    }
                }
                Rectangle {
                    height: 3
                    width: parent.width
                    visible: currentIndex == index
                    color: highlightColor
                }
            }
        }
    }
}
