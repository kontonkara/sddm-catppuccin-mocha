import QtQuick 2.15
import SddmComponents 2.0

Item {
    id: sessionSelectorRoot
    height: column.height

    property int currentIndex: sessionModel.lastIndex

    Column {
        id: column
        width: parent.width
        spacing: 8

        Text {
            text: "Session"
            font.pixelSize: 14
            color: "#a6adc8"
            font.bold: true
        }

        Rectangle {
            id: selectorButton
            width: parent.width
            height: 45
            color: mouseArea.containsMouse ? "#45475a" : "#313244"
            radius: 8
            border.color: "#45475a"
            border.width: 2

            Row {
                anchors.fill: parent
                anchors.margins: 12
                spacing: 10

                Text {
                    width: parent.width - 24
                    anchors.verticalCenter: parent.verticalCenter
                    text: {
                        var idx = sessionSelectorRoot.currentIndex
                        if (sessionModel && sessionModel.rowCount() > 0 && idx >= 0 && idx < sessionModel.rowCount()) {
                            var modelIndex = sessionModel.index(idx, 0)
                            var name = sessionModel.data(modelIndex, 256)
                            return name || "Unknown"
                        }
                        return "No sessions"
                    }
                    font.pixelSize: 14
                    color: "#cdd6f4"
                    elide: Text.ElideRight
                }

                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    text: "▼"
                    font.pixelSize: 12
                    color: "#a6adc8"
                    rotation: dropdownContainer.visible ? 180 : 0

                    Behavior on rotation {
                        NumberAnimation { duration: 200 }
                    }
                }
            }

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: dropdownContainer.visible = !dropdownContainer.visible
            }
        }
    }

    // Dropdown container positioned absolutely outside the layout flow
    Item {
        id: dropdownContainer
        anchors.top: column.bottom
        anchors.topMargin: 8
        anchors.left: parent.left
        width: parent.width
        height: dropdown.height
        visible: false
        z: 1000

        Rectangle {
            id: dropdown
            width: parent.width
            height: Math.min(listView.contentHeight + 4, 200)
            color: "#313244"
            radius: 8
            border.color: "#45475a"
            border.width: 2
            clip: true

            ListView {
                id: listView
                anchors.fill: parent
                anchors.margins: 2
                model: sessionModel
                currentIndex: sessionSelectorRoot.currentIndex

                delegate: Rectangle {
                    width: listView.width
                    height: 40
                    color: itemMouseArea.containsMouse ? "#45475a" : "transparent"
                    radius: 6

                    Text {
                        anchors.fill: parent
                        anchors.leftMargin: 12
                        anchors.rightMargin: 12
                        text: model.name
                        font.pixelSize: 14
                        color: "#cdd6f4"
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                    }

                    MouseArea {
                        id: itemMouseArea
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            sessionSelectorRoot.currentIndex = index
                            dropdownContainer.visible = false
                        }
                    }
                }
            }
        }
    }

    // Global click handler to close dropdown
    Connections {
        target: root
        function onPressed() {
            if (dropdownContainer.visible) {
                dropdownContainer.visible = false
            }
        }
    }
}
