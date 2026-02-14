import QtQuick 2.15
import QtQuick.Controls 2.15
import SddmComponents 2.0
import "Components"

Rectangle {
    id: root

    property bool showPassword: false
    property string usernameMode: config.stringValue("UsernameMode") || "editable"
    property string primaryMonitorName: config.stringValue("PrimaryMonitor") || ""
    property bool showBackgroundOnSecondary: config.boolValue("ShowBackgroundOnSecondary") !== false

    property string currentScreenName: ""
    property bool isPrimaryScreen: false
    property bool initialized: false

    Timer {
        interval: 50
        running: true
        repeat: false
        onTriggered: detectScreen()
    }

    function detectScreen() {
        var win = root.Window.window

        if (win) {
            // Match by window position
            for (var i = 0; i < Qt.application.screens.length; i++) {
                var screen = Qt.application.screens[i]
                if (Math.abs(win.x - screen.virtualX) < 100 && Math.abs(win.y - screen.virtualY) < 100) {
                    currentScreenName = screen.name
                    break
                }
            }
        }

        // Determine if primary
        if (currentScreenName !== "") {
            if (primaryMonitorName === "") {
                isPrimaryScreen = (currentScreenName === Qt.application.screens[0].name)
            } else {
                isPrimaryScreen = (currentScreenName === primaryMonitorName)
            }
        }

        console.log("Screen:", currentScreenName, "| Primary:", isPrimaryScreen)

        initialized = true

        // Start animations if primary
        if (isPrimaryScreen) {
            loginFormOpacityAnim.start()
            loginFormSlideAnim.start()
            powerButtonsOpacityAnim.start()
        }
    }

    color: "#1e1e2e"

    // Debug text (remove after testing)
    Text {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: 10
        text: "Screen: " + (currentScreenName || "...") + " | Primary: " + isPrimaryScreen
        color: "#b4befe"
        font.pixelSize: 14
        font.bold: true
        z: 1000
        visible: false  // Set to true for debugging
    }

    Background {
        id: background
        anchors.fill: parent
        visible: isPrimaryScreen || showBackgroundOnSecondary
    }

    Rectangle {
        anchors.fill: parent
        color: "#1e1e2e"
        visible: !isPrimaryScreen && !showBackgroundOnSecondary
    }

    ClockComponent {
        id: clock
        visible: isPrimaryScreen
    }

    Column {
        id: loginForm
        anchors.centerIn: parent
        spacing: 20
        width: 350
        opacity: 0
        visible: isPrimaryScreen

        NumberAnimation {
            id: loginFormOpacityAnim
            target: loginForm
            property: "opacity"
            from: 0
            to: 1
            duration: 800
            easing.type: Easing.OutCubic
        }

        PropertyAnimation {
            id: loginFormSlideAnim
            target: loginForm
            property: "anchors.verticalCenterOffset"
            from: 50
            to: 0
            duration: 800
            easing.type: Easing.OutCubic
        }

        InputField {
            id: usernameField
            width: parent.width
            label: "Username"
            icon: "Assets/User.svg"
            text: userModel.lastUser
            readOnly: usernameMode === "locked"

            onReturnPressed: passwordField.focusField()
        }

        PasswordField {
            id: passwordField
            width: parent.width
            label: "Password"
            showPassword: root.showPassword

            onTogglePassword: root.showPassword = !root.showPassword
            onReturnPressed: loginButton.doLogin()
        }

        LoginButton {
            id: loginButton
            width: parent.width

            onDoLogin: sddm.login(usernameField.getText(), passwordField.getText(), sessionSelector.currentIndex)
        }

        SessionSelector {
            id: sessionSelector
            width: parent.width
        }
    }

    PowerButtons {
        id: powerButtons
        visible: isPrimaryScreen
        opacity: 0

        NumberAnimation {
            id: powerButtonsOpacityAnim
            target: powerButtons
            property: "opacity"
            from: 0
            to: 1
            duration: 800
            easing.type: Easing.OutCubic
        }
    }

    MouseArea {
        anchors.fill: parent
        z: -1
        enabled: isPrimaryScreen
        onClicked: {
            if (sessionSelector.isDropdownVisible()) {
                sessionSelector.closeDropdown()
            }
        }
    }
}
