import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtMultimedia 5.9
import QZXing 2.3

Item {
    property int detectedTags: 0
    property string lastTag: ""
    property bool detailVisible: false

    Camera {
        id:camera
        focus {
            focusMode: CameraFocus.FocusContinuous
            focusPointMode: CameraFocus.FocusPointAuto
        }
    }

    VideoOutput {
        id: videoOutput
        source: camera
        anchors.centerIn: parent
        width: Math.min(parent.width, parent.height)
        height: Math.min(parent.width, parent.height)
        autoOrientation: true
        fillMode: VideoOutput.PreserveAspectCrop
        filters: [ zxingFilter ]
        transform: Rotation { // bugfix, until update Qt5.9.4 or 5.10
            origin.x: videoOutput.width / 2;
            origin.y: videoOutput.height / 2;
            axis.x:0; axis.y:1; axis.z:0
            angle: 180 // Qt.platform.os === "android" ? 180 : 0
        }
        Rectangle {
            id: captureZone
            border.color: "green"
            border.width: 2
            color: "transparent"
            width: parent.width * 2 / 3
            height: parent.height * 2 / 3
            anchors.centerIn: parent
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                camera.focus.customFocusPoint = Qt.point(mouse.x / width,  mouse.y / height);
                camera.focus.focusMode = CameraFocus.FocusMacro;
                camera.focus.focusPointMode = CameraFocus.FocusPointCustom;
                camera.searchAndLock()
            }
        }
    }

    QZXingFilter {
        id: zxingFilter
        captureRect: {
            // setup bindings
            videoOutput.contentRect;
            videoOutput.sourceRect;
            return videoOutput.mapRectToSource(videoOutput.mapNormalizedRectToItem(Qt.rect(
                0.15, 0.15, 0.7, 0.7
            )));
        }

        decoder {
            enabledDecoders: QZXing.DecoderFormat_EAN_13 | QZXing.DecoderFormat_CODE_39 | QZXing.DecoderFormat_QR_CODE
            onTagFound: {
                // console.log(tag + " | " + decoder.foundedFormat() + " | " + decoder.charSet());
                detectedTags++;
                lastTag = tag;
            }
            tryHarder: false
        }

        property int framesDecoded: 0
        property real timePerFrameDecode: 0

        onDecodingFinished: {
           timePerFrameDecode = (decodeTime + framesDecoded * timePerFrameDecode) / (framesDecoded + 1);
           framesDecoded++;
        }
    }

    Rectangle {
        anchors.fill: qrDetailsBox
        visible: detailVisible
        anchors.margins: -5
        color: "white"
        opacity: 0.5
    }

    Column {
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10
        visible: detailVisible

        id: qrDetailsBox
        spacing: 2
        Label {
            text: "status: " + camStatus()
            function camStatus() {
                if (camera.lockStatus == Camera.Unlocked)
                    return "unlock"
                else if (camera.lockStatus == Camera.Searching)
                    return "searching..."
                else
                    return "lock"
            }
        }
        Label { text: "detected count: " + detectedTags }
        Label { text: "Tags: " + lastTag }
        Label { text: "timePerFrame: " + zxingFilter.timePerFrameDecode }
    }
}
