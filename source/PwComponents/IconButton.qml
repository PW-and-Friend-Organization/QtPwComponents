import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import "qrc:/ionicons/ionicons.js" as Code

Button {
    property string source: ""
    font.family: "Ionicons"
    text: Code.img[source] || ""
}
