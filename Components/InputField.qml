import QtQuick 2.15

Column {
    id: inputField
    spacing: 8

    property string label: ""
    property string icon: ""
    property alias text: textInput.text
    property bool readOnly: false

    signal returnPressed()

    function getText() {
        return textInput.text
    }

    function focusField() {
        if (!readOnly) {
            textInput.focus = true
        }
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
        color: readOnly ? "#45475a" : "#313244"
        radius: 8
        border.color: (!readOnly && textInput.activeFocus) ? "#b4befe" : "#45475a"
        border.width: 2
        opacity: readOnly ? 0.7 : 1.0

        Behavior on border.color {
            ColorAnimation { duration: 200 }
        }

        Behavior on color {
            ColorAnimation { duration: 200 }
        }

        Row {
            anchors.fill: parent
            anchors.margins: 10
            spacing: 10

            Image {
                source: "../" + icon
                width: 24
                height: 24
                anchors.verticalCenter: parent.verticalCenter
                opacity: (!readOnly && textInput.activeFocus) ? 1.0 : 0.7

                Behavior on opacity {
                    NumberAnimation { duration: 200 }
                }
            }

            TextInput {
                id: textInput
                width: parent.width - 34
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 16
                color: "#cdd6f4"
                selectionColor: "#b4befe"
                selectedTextColor: "#1e1e2e"
                readOnly: inputField.readOnly
                activeFocusOnTab: !inputField.readOnly

                Keys.onPressed: function(event) {
                    if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                        inputField.returnPressed()
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    enabled: inputField.readOnly
                    cursorShape: Qt.ArrowCursor
                }
            }
        }
    }
}
