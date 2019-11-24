# QtPwComponent

An extended material theme component created on top of the Qt default component.

The objective of sharing this component is to encourage the use of this underdog Qt framework, as a fun and easy to build yet still presentable android applications.

This project may reference to many places which I may not gave correct credit to. Do sent me a message so that I can reference it, accordingly.

For that, thanks for giving this library a look at this.

Features:
- Hot-loading functionality via NodeJS (watch and websocket function)
- Dark / Light theme toggle support
- All the extra components use for building a decent looking android apps.
  + Badge
  + ComboBox
  + Card
  + FloatingActionButton
  + TimePicker
  + DatePicker
  + Popup with Checkbox selection
  + Popup with List selection
  + Camera Controller
  + Pull to refresh ListView
  + JsonPath support
  + QR Scanner
  + and many more...

Latest test was against Qt 5.9.6.

# Hot Loading

To start the hot loading, you'll need to install NodeJS of any version.
`cd example\debug`
`npm start`

# Test Application

Open the `example\TestApplication\TestApplication.pro`.

## Theme

![](doc-image/Theme-Light.png) ![](doc-image/Theme-Dark.png)

```
Page {
    id: page
    Material.theme: Material.Light
    Material.primary: Material.Blue
    Material.accent: Material.Blue
}
```

### Badge

![](doc-image/Badge-Light.png) ![](doc-image/Badge-Dark.png)

```
AppComponent.Badge {
    text: "This is badge"
}
```

### Card

![](doc-image/Card-Light.png) ![](doc-image/Card-Dark.png)

```
AppComponent.Card {
    width: 200
    height: 100
    Label {
        anchors.centerIn: parent
        text: "Display Card"
    }
}
```

### Chip

![](doc-image/Chip-Light.png) ![](doc-image/Chip-Dark.png)

```
AppComponent.Chip {
    iconText: "person"
    text: "chip"
    actionText: "android-cancel"
}
```

### ComboBox

![](doc-image/Combo-Light.png) ![](doc-image/Combo-Dark.png)

```
AppComponent.ComboBox {
    model: ["Apple", "Banana", "Carrot"]
}
```

### DatePicker

![](doc-image/DatePicker-Light.png) ![](doc-image/DatePicker-Dark.png)

```
AppComponent.DatePicker {
    selectedDate: new Date("2020-01-01")
    Component.onCompleted: open()
}
```

### TimePicker

![](doc-image/TimePicker-Light.png) ![](doc-image/TimePicker-Dark.png)

```
AppComponent.TimePicker {
    selectedTime: new Date("2020-01-01 08:30:00")
    Component.onCompleted: open()
}
```

### FloatingActionButton

![](doc-image/FloatingActionButton-Light.png) ![](doc-image/FloatingActionButton-Dark.png)

```
AppComponent.FloatingActionButton {
    ionicon: "code"
}
```

### FloatingExtraButton

![](doc-image/FloatingExtraButton-Light.png) ![](doc-image/FloatingExtraButton-Dark.png)

```
AppComponent.FloatingExtraButton {
    model: ListModel {
        ListElement {
            ionicon: "social-github"
            name: "github"
            color: "orange"
        }
        ListElement {
            ionicon: "social-google"
        }
        ListElement {
            ionicon: "social-instagram"
        }
    }
}
```

### IconButton

![](doc-image/IconButton-Light.png)

```
AppComponent.IconButton {
    anchors.centerIn: parent
    source: "social-github"
}
```

### ListViewEx

![](doc-image/ListViewEx-Light.png)

```
AppComponent.ListViewEx {
    anchors.centerIn: parent
    model: [1,2,3,4,5,6,7]
    delegate: Label {
        anchors.horizontalCenter: parent.horizontalCenter
        text: modelData
    }
    onRefresh: console.log("Refreshed")
}
```

### MediaIoniconDelegate

![](doc-image/MediaIoniconDelegate-Light.png)

```
AppComponent.ListViewEx {
    anchors.centerIn: parent
    model: [1]
    delegate: AppComponent.MediaIoniconDelegate {
        ioniconText: "code"
        overlineText: "Overline Text"
        //metaStatusText: "Status"
        metaIconText: "power"
        titleText: "Title Text"
        descriptionText: "Description for anything"
    }
}
```

### PopupCheckBox

![](doc-image/PopupCheckBox-Light.png) ![](doc-image/PopupCheckBox-Dark.png)

```
AppComponent.PopupCheckBox {
    title: "Fruit"
    model: ["Apple", "Banana", "Carrot"]
    selected: ["Banana"]
    Component.onCompleted: open()
}
```

### PopupSelection

![](doc-image/PopupSelection-Light.png) ![](doc-image/PopupSelection-Dark.png)

```
AppComponent.PopupSelection {
    title: "Fruit"
    model: ["Apple", "Banana", "Carrot"]
    Component.onCompleted: open()
}
```

### PopupConfirmation

![](doc-image/PopupConfirmation-Light.png) ![](doc-image/PopupConfirmation-Dark.png)

```
AppComponent.PopupConfirmation {
    title.text: "Confirmation"
    desc.text: "Are you sure?"
    onCancel: console.log("cancel")
    onConfirm: console.log("confirm")
    Component.onCompleted: open()
}
```

### QRScannerContainer

![](doc-image/QRScannerContainer-Light.png)

```
AppComponent.QRScannerContainer {
    anchors.fill: parent
    onLastTagChanged: console.log(lastTag)
}
```
