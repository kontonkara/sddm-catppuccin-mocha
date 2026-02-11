import QtQuick 2.15

Column {
    anchors {
        top: parent.top
        topMargin: 60
        horizontalCenter: parent.horizontalCenter
    }
    spacing: 8

    Text {
        id: timeLabel
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: 72
        font.bold: true
        color: "#b4befe"  // lavender

        function updateTime() {
            text = Qt.formatDateTime(new Date(), "HH:mm:ss")
        }
    }

    Text {
        id: dateLabel
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: 24
        color: "#cdd6f4"  // text
        text: Qt.formatDateTime(new Date(), "dddd, MMMM d, yyyy")
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            timeLabel.updateTime()
            dateLabel.text = Qt.formatDateTime(new Date(), "dddd, MMMM d, yyyy")
        }
    }

    Component.onCompleted: {
        timeLabel.updateTime()
    }
}
