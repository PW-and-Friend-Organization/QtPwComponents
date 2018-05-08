import QtQuick 2.9

import "ionicons.js" as Code

Text {
    property string source: ""
    property int size: 25
    property alias style: text.style

    id: text
    font.pixelSize: size
    font.family: "Ionicons"
    height: size
    width: size
    text: Code.img[source] || ""
    color: "#000"
    verticalAlignment: Text.AlignVCenter
    horizontalAlignment: Text.AlignHCenter
}


