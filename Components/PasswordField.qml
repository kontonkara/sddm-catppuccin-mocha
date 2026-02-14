import QtQuick 2.15

Column {
    id: passwordField
    spacing: 8

    property string label: "Password"
    property string iconColor: "W"
    property bool showPassword: false

    signal returnPressed()
    signal togglePassword()

    function getText() {
        return textInput.text
    }

    function focusField() {
        textInput.focus = true
    }

    Text {
        text: label
        font.pixelSize: 14
        color: "#a6adc8"
        font.bold: true
    }

    Rectangle {
        width: parent.width
        height: 45
        color: "#313244"
        radius: 8
        border.color: textInput.activeFocus ? "#b4befe" : "#45475a"
        border.width: 2

        Behavior on border.color {
            ColorAnimation { duration: 200 }
        }

        Row {
            anchors.fill: parent
            anchors.margins: 10
            spacing: 10

            Image {
                id: passwordIcon
                source: "../Assets/Password" + iconColor + ".svg"
                width: 24
                height: 24
                anchors.verticalCenter: parent.verticalCenter
                opacity: textInput.activeFocus ? 1.0 : 0.7

                Behavior on opacity {
                    NumberAnimation { duration: 200 }
                }
            }

            TextInput {
                id: textInput
                width: parent.width - 68
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 16
                color: "#cdd6f4"
                echoMode: showPassword ? TextInput.Normal : TextInput.Password
                selectionColor: "#b4befe"
                selectedTextColor: "#1e1e2e"
                focus: true

                Keys.onPressed: function(event) {
                    if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                        passwordField.returnPressed()
                    }
                }
            }

            Image {
                id: toggleIcon
                source: showPassword ? "../Assets/PasswordShow" + iconColor + ".svg" : "../Assets/PasswordHide" + iconColor + ".svg"
                width: 24
                height: 24
                anchors.verticalCenter: parent.verticalCenter
                scale: toggleMouseArea.pressed ? 0.9 : 1.0

                Behavior on scale {
                    NumberAnimation { duration: 100 }
                }

                MouseArea {
                    id: toggleMouseArea
                    anchors.fill: parent
                    onClicked: passwordField.togglePassword()
                    cursorShape: Qt.PointingHandCursor
                }
            }
        }
    }
}
