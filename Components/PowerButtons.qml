import QtQuick 2.15
import SddmComponents 2.0

Row {
    anchors {
        bottom: parent.bottom
        bottomMargin: 40
        horizontalCenter: parent.horizontalCenter
    }
    spacing: 20
    opacity: 0

    NumberAnimation on opacity {
        from: 0
        to: 1
        duration: 800
        easing.type: Easing.OutCubic
    }

    Rectangle {
        width: 50
        height: 50
        color: rebootMouseArea.containsMouse ? "#45475a" : "#313244"
        radius: 25
        scale: rebootMouseArea.pressed ? 0.9 : 1.0

        Behavior on color {
            ColorAnimation { duration: 200 }
        }

        Behavior on scale {
            NumberAnimation { duration: 100 }
        }

        Image {
            source: "../Assets/Reboot.svg"
            width: 28
            height: 28
            anchors.centerIn: parent
        }

        MouseArea {
            id: rebootMouseArea
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: sddm.reboot()
        }
    }

    Rectangle {
        width: 50
        height: 50
        color: shutdownMouseArea.containsMouse ? "#45475a" : "#313244"
        radius: 25
        scale: shutdownMouseArea.pressed ? 0.9 : 1.0

        Behavior on color {
            ColorAnimation { duration: 200 }
        }

        Behavior on scale {
            NumberAnimation { duration: 100 }
        }

        Image {
            source: "../Assets/Shutdown.svg"
            width: 28
            height: 28
            anchors.centerIn: parent
        }

        MouseArea {
            id: shutdownMouseArea
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: sddm.powerOff()
        }
    }
}
