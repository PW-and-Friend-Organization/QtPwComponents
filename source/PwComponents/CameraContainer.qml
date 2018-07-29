import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtMultimedia 5.9
import "." as AppComponent

Item {
    id: root

    signal imageSaved(var imagePath)
    signal openImage(var imagePath)
    property alias camera: camera
    property alias videoOutput: videoOutput

    Camera {
        id: camera
        focus.focusMode: CameraFocus.FocusAuto
        focus.focusPointMode: CameraFocus.FocusPointAuto

        imageCapture.onImageCaptured: controller.preview.source = preview
        imageCapture.onImageSaved: {
            var imagePath;
            if (Qt.platform.os == "windows")
              imagePath = "file://" + path.replace("\\", "/").substring(2)
            else
              imagePath = "file://" + path.replace("\\", "/").substring(1)

            console.log("SaveImage", Qt.platform.os, imagePath)
            root.imageSaved(imagePath)
        }
    }

    VideoOutput {
        id: videoOutput
        source: camera
        anchors.centerIn: parent
        width: parent.width
        height: parent.height
        autoOrientation: true
        fillMode: VideoOutput.PreserveAspectCrop
        transform: Rotation { // bugfix, until update Qt5.9.4 or 5.10
            origin.x: videoOutput.width / 2;
            origin.y: videoOutput.height / 2;
            axis.x:0; axis.y:1; axis.z:0
            angle: Qt.platform.os === "android" ? 0 : 180
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: camera.searchAndLock()
    }

    AppComponent.CameraController {
        id: controller
        capture.onClicked: camera.imageCapture.capture()
        onOpenImage: root.openImage(imagePath)
        slider.from: 1
        slider.to: camera.maximumDigitalZoom
        slider.value: camera.digitalZoom
        slider.onValueChanged: camera.digitalZoom = slider.value
    }
}
