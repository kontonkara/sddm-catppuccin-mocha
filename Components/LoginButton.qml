import QtQuick 2.15

Rectangle {
    id: loginButton
    height: 45
    color: mouseArea.containsMouse ? "#a18cd1" : "#b4befe"
    radius: 8
    scale: mouseArea.pressed ? 0.98 : 1.0

    property string iconColor: "W"

    signal doLogin()

    Behavior on color {
        ColorAnimation { duration: 200 }
    }

    Behavior on scale {
        NumberAnimation { duration: 100 }
    }

    Text {
        anchors.centerIn: parent
        text: "Login"
        font.pixelSize: 16
        font.bold: true
        color: "#1e1e2e"
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: loginButton.doLogin()
    }
}
