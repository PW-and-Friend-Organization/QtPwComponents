import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.2
import "qrc:/ionicons"
import PwComponents 1.0 as AppComponent
import QtGraphicalEffects 1.0
import "." as TE

Page {
    id: page
    Material.theme: Material.Dark
    Material.primary: Material.Blue
    Material.accent: Material.Blue
    property bool inPortrait: width < height
    Drawer {
        id: drawer

        width: 260
        height: window.height

        modal: inPortrait
        interactive: inPortrait
        position: inPortrait ? 0 : 1
        visible: !inPortrait

        ListView {
            id: listView
            anchors.fill: parent

            headerPositioning: ListView.OverlayHeader
            header: Pane {
                id: header
                z: 2
                width: parent.width

                contentHeight: logo.height

                Rectangle {
                    id: logo
                    width: parent.width
                    color: "green"
                }

                MenuSeparator {
                    parent: header
                    width: parent.width
                    anchors.verticalCenter: parent.bottom
                    visible: !listView.atYBeginning
                }
            }

            footer: ItemDelegate {
                id: footer
                text: qsTr("Footer")
                width: parent.width

                MenuSeparator {
                    parent: footer
                    width: parent.width
                    anchors.verticalCenter: parent.top
                }
            }

            model: 10

            delegate: ItemDelegate {
                text: qsTr("Title %1").arg(index + 1)
                width: parent.width
            }

            ScrollIndicator.vertical: ScrollIndicator { }
        }
    }

    Flickable {
        id: flickable

        anchors.fill: parent
        anchors.leftMargin: !inPortrait ? drawer.width : undefined

        topMargin: 20
        bottomMargin: 20
        contentHeight: column.height

        Column {
            id: column
            spacing: 20
            anchors.margins: 20
            anchors.left: parent.left
            anchors.right: parent.right

            AppComponent.Card {
                width: parent.width
                height: 300
            }

            Label {
                font.pixelSize: 22
                width: parent.width
                elide: Label.ElideRight
                horizontalAlignment: Qt.AlignHCenter
                text: qsTr("Side Panel Example")
            }

            Label {
                width: parent.width
                wrapMode: Label.WordWrap
                text: qsTr("This example demonstrates how Drawer can be used as a non-closable persistent side panel.\n\n" +
                           "When the application is in portrait mode, the drawer is an interactive side panel that can " +
                           "be swiped open from the left edge. When the application is in landscape mode, the drawer " +
                           "and the content are laid out side by side.\n\nThe application is currently in %1 mode.").arg(inPortrait ? qsTr("portrait") : qsTr("landscape"))
            }
        }

        ScrollIndicator.vertical: ScrollIndicator { }
    }
}
