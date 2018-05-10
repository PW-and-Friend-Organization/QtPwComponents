import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.3
import "qrc:/ionicons"

ItemDelegate {
    signal itemClicked
    signal metaIconClicked
    property alias ioniconText: icon.source
    property alias overlineText: overline.text
    property alias metaStatusText: metaStatus.text
    property alias metaIconText: metaIcon.source
    property alias titleText: title.text
    property alias descriptionText: description.text

    property alias icon: icon
    property alias metaStatus: metaStatus
    property alias metaIcon: metaIcon
    property alias overline: overline
    property alias title: title
    property alias description: description

    width: ListView.view.width
    height: description.visible || overline.visible ? 88 : 56

    MouseArea {
        anchors.fill: parent
        onClicked: itemClicked()
    }

    RowLayout {
        spacing: 16
        anchors { verticalCenter: parent.verticalCenter; left: parent.left; right: parent.right; margins: 16 }
        Ionicon {
            id: icon
            anchors.top: parent.top; Layout.preferredWidth: 40
            source: "android-contact"; size: 40; color: Material.foreground
        }
        Column {
            Layout.fillWidth: true
            Label {
                id: overline
                visible: text !== ""
                font.capitalization: Font.AllUppercase
                font.letterSpacing: 1.5
                font.pointSize: defaultPointSize - 2
                opacity: 0.7
            }
            RowLayout {
                anchors { left: parent.left; right: parent.right }
                Label {
                    id: title
                    text: model.name
                    font.weight: Font.Medium; font.pointSize: defaultPointSize + 1
                    Layout.fillWidth: true
                }
                Label {
                    id: metaStatus
                    Layout.preferredWidth: implicitWidth
                    font.capitalization: Font.AllUppercase
                    font.pointSize: defaultPointSize - 1
                }
                Ionicon {
                    id: metaIcon
                    visible: source !== ""
                    Layout.preferredWidth: implicitWidth
                    source: ""; size: 24; color: Material.foreground
                    MouseArea {
                        anchors { fill: parent; margins: -12 }
                        onClicked: metaIconClicked()
                    }
                }
            }
            Label {
                id: description
                text: model.text
                wrapMode: Label.WordWrap; width: parent.width
                opacity: 0.8
            }
        }
    }

    Rectangle {
        width: parent.width; height: 1
        anchors.bottom: parent.bottom
        color: Material.foreground
        opacity: 0.3
    }
}
