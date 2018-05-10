import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.2
import "qrc:/ionicons"
import PwComponents 1.0 as AppComponent
import QtGraphicalEffects 1.0
import "." as TE

Page {
    Material.theme: Material.Light
    Material.primary: Material.Blue
    Material.accent: Material.Blue

    Flow {
        topPadding: 10
        leftPadding: 10
        spacing: 10
        AppComponent.Chip {
            text: "Heart"
        }
        AppComponent.Badge {
            text: "Heart"
        }
    }

//    ListModel {
//        id: listModel
//        ListElement { name: "Choong Pak Wai"; when: "yesterday"; text: "Tehada Telkjda dlakjd vpod lfkjd fsdfsf dfdsf fdsfds fds fsdf3w er sdf sd fsd" }
//        ListElement { name: "Choong Pak Onn"; when: "yesterday"; text: "Tehada Telkjda dlakjd vpod lfkjd fsdfsf" }
//    }


//    TE.ListViewEx {
//        anchors.fill: parent
//        model: listModel
//        delegate: TE.MediaIoniconDelegate {
//            titleText: model.name
//            descriptionText: model.text
//        }
//    }
}
