import QtQuick 2.15

Rectangle {
    id: loginButton
    height: 45
    color: mouseArea.containsMouse ? "#a18cd1" : "#b4befe"
    radius: 8

    signal doLogin()

    Row {
        anchors.centerIn: parent
        spacing: 10

        Image {
            source: "../Assets/Login.svg"
            width: 20
            height: 20
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            text: "Login"
            font.pixelSize: 16
            font.bold: true
            color: "#1e1e2e"
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: loginButton.doLogin()
    }
}
