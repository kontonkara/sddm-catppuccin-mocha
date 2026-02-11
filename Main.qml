import QtQuick 2.15
import QtQuick.Controls 2.15
import SddmComponents 2.0
import "Components"

Rectangle {
    id: root
    width: 1920
    height: 1080
    color: "#1e1e2e"  // Catppuccin Mocha base

    property bool showPassword: false
    property string usernameMode: config.stringValue("UsernameMode") || "editable"

    // Clock component at the top
    ClockComponent {
        id: clock
    }

    // Center login form
    Column {
        id: loginForm
        anchors.centerIn: parent
        spacing: 20
        width: 350

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

    // Power buttons at the bottom
    PowerButtons {
        id: powerButtons
    }

    // Global click handler to close dropdowns
    MouseArea {
        anchors.fill: parent
        z: -1
        onClicked: {
            if (sessionSelector.isDropdownVisible()) {
                sessionSelector.closeDropdown()
            }
        }
    }
}
