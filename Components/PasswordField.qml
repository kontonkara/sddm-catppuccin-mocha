import QtQuick 2.15

Column {
    id: passwordField
    spacing: 8

    property string label: "Password"
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

        Row {
            anchors.fill: parent
            anchors.margins: 10
            spacing: 10

            Image {
                source: "../Assets/Password.svg"
                width: 24
                height: 24
                anchors.verticalCenter: parent.verticalCenter
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
                source: showPassword ? "../Assets/PasswordShow.svg" : "../Assets/PasswordHide.svg"
                width: 24
                height: 24
                anchors.verticalCenter: parent.verticalCenter

                MouseArea {
                    anchors.fill: parent
                    onClicked: passwordField.togglePassword()
                    cursorShape: Qt.PointingHandCursor
                }
            }
        }
    }
}
