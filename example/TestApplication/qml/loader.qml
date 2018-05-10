import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.1
import QtQuick.Window 2.2
import QtWebSockets 1.0

ApplicationWindow {
    id: window

    visible: true
    title: qsTr("Test Application")

    width: 480
    height: 640

    // property app level
    property bool __debug: false
    property string __ws_host: "http://127.0.0.1:44333"
    property string __ws_debug: "ws://127.0.0.1:44334"
    property bool __landscape: Screen.orientation === Qt.LandscapeOrientation
    property int defaultPointSize: font.pointSize

    // main signal for opening module
    signal intent(string action, var extras)

    // webfont icons | they have to be loaded before rest of qml
    FontLoader { source: "qrc:/fonts/Roboto-Thin.ttf" }
    FontLoader { source: "qrc:/fonts/Roboto-Light.ttf" }
    FontLoader { source: "qrc:/fonts/Roboto-Regular.ttf" }
    FontLoader { source: "qrc:/fonts/Roboto-Medium.ttf" }
    FontLoader { source: "qrc:/fonts/Roboto-Bold.ttf" }
    FontLoader { source: "qrc:/fonts/Roboto-Black.ttf" }
    FontLoader { source: "qrc:/ionicons/ionicons.ttf" }
    font.family: "Roboto" // default font size

    // main application content
    // in debug mode fetched from http, in production, builtin version is used
    Loader {
        id: apploader
        source: __debug ? "%1/main.qml".arg(__ws_host) : "qrc:/main.qml"
        anchors.fill: parent
        asynchronous: false

        function loadQml(page) {
            return __debug ? "%1/".arg(__ws_host) + page : "qrc:/" + page
        }

        function reload() {
            if (apploader.status === Loader.Loading)
                return console.log("Ignoring reload request, reload in progress")

            console.log("application reload")

            var src = source
            source = ""
            __hotReload.clearCache()
            source = src

            // restart websocket debug server
            wsDebugServer.active = false
            wsDebugServer.active = true
        }
    }

    // websocket client used for development
    WebSocket {
        onActiveChanged: console.log("ws: ", active)
        id: wsDebugServer
        url: __ws_debug
        active: __debug
        onStatusChanged: {
            if(status === WebSocket.Error)
                console.log("WebSocker error:", errorString)
        }
        onTextMessageReceived: {
            console.log("WebSocket message:", message)
            var msg = JSON.parse(message)
            if(msg.action === "reload")
                apploader.reload()
        }
    }

    Label {
       id: errorMessage
       color: "white"
       text: "Unable to load remote qml, check if server is available and running"
       width: 300
       wrapMode: Label.WordWrap
       anchors.centerIn: parent
       enabled: __debug && apploader.status === Loader.Error
       visible: enabled

    }

    Button
    {
        anchors.top: errorMessage.bottom
        anchors.topMargin: height
        anchors.horizontalCenter: errorMessage.horizontalCenter
        text: "Retry"
        onClicked: apploader.reload()
        enabled: errorMessage.enabled
        visible: enabled
    }
}
