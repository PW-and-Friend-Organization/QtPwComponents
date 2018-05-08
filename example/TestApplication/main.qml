import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import PwComponents 1.0 as AppComponent

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    property int defaultPointSize: font.pointSize

    FontLoader { source: "qrc:/ionicons/ionicons.ttf" }
}
