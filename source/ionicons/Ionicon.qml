import QtQuick 2.9

import "ionicons.js" as Code

Text {
    property string source: ""
    property int size: 24
    property alias style: text.style

    id: text
    font.pixelSize: size
    font.family: "Ionicons"
    height: size
    width: size
    text: Code.img[source] || ""
    verticalAlignment: Text.AlignVCenter
    horizontalAlignment: Text.AlignHCenter
}


