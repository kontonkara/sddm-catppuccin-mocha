import QtQuick 2.15

Item {
    id: backgroundRoot

    property string backgroundType: config.stringValue("BackgroundType") || "color"
    property string backgroundPath: config.stringValue("BackgroundPath") || ""
    property real backgroundBlur: config.realValue("BackgroundBlur") || 0
    property real backgroundDim: config.realValue("BackgroundDim") || 1.0

    // Color background (default and fallback)
    Rectangle {
        anchors.fill: parent
        color: "#1e1e2e"
        visible: backgroundType === "color" || backgroundType === "video"
    }

    // Image background (static)
    Image {
        id: imageBackground
        anchors.fill: parent
        source: (backgroundType === "image" && backgroundPath && !backgroundPath.endsWith(".gif")) ? backgroundPath : ""
        fillMode: Image.PreserveAspectCrop
        visible: backgroundType === "image" && !backgroundPath.endsWith(".gif") && status === Image.Ready
        asynchronous: true
        cache: false

        layer.enabled: backgroundBlur > 0
        layer.effect: ShaderEffect {
            property variant source: imageBackground
            property real blur: backgroundBlur / 100.0

            fragmentShader: "
                uniform lowp sampler2D source;
                uniform lowp float blur;
                uniform lowp float qt_Opacity;
                varying highp vec2 qt_TexCoord0;

                void main() {
                    lowp vec4 color = vec4(0.0);
                    int samples = int(blur * 10.0);
                    if (samples < 1) {
                        gl_FragColor = texture2D(source, qt_TexCoord0) * qt_Opacity;
                        return;
                    }

                    float offset = blur * 0.01;
                    for (int x = -samples; x <= samples; x++) {
                        for (int y = -samples; y <= samples; y++) {
                            vec2 coord = qt_TexCoord0 + vec2(float(x), float(y)) * offset;
                            color += texture2D(source, coord);
                        }
                    }
                    int total = (samples * 2 + 1) * (samples * 2 + 1);
                    gl_FragColor = (color / float(total)) * qt_Opacity;
                }
            "
        }
    }

    // Animated image background (GIF)
    AnimatedImage {
        id: animatedBackground
        anchors.fill: parent
        source: (backgroundType === "image" && backgroundPath && backgroundPath.endsWith(".gif")) ? backgroundPath : ""
        fillMode: Image.PreserveAspectCrop
        visible: backgroundType === "image" && backgroundPath.endsWith(".gif") && status === AnimatedImage.Ready
        playing: visible
        asynchronous: true
    }

    // Dim overlay
    Rectangle {
        anchors.fill: parent
        color: "black"
        opacity: 1.0 - backgroundDim
        visible: backgroundDim < 1.0
    }

    // Fallback to color if image fails to load
    Rectangle {
        anchors.fill: parent
        color: "#1e1e2e"
        visible: (backgroundType === "image" && imageBackground.status === Image.Error &&
                 (animatedBackground.status === AnimatedImage.Error || !backgroundPath.endsWith(".gif")))
    }

    // Info text for video type (not supported)
    Text {
        anchors.centerIn: parent
        text: "Video backgrounds are not supported in this Qt version.\nUsing solid color instead."
        color: "#a6adc8"
        font.pixelSize: 14
        horizontalAlignment: Text.AlignHCenter
        visible: backgroundType === "video"
        opacity: 0.5
    }
}
