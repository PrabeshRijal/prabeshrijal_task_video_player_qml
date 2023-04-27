

import QtQuick 2.0
import QtQuick.Window 2.0
import QtMultimedia

Window {
    width: 640
    height: 480
    visible: true

    // To select a video file
    FileDialog {
        id: fileDialog
        title: "Please choose video file"
        nameFilters: ["Video Files (*.mp4 *.avi *.mov)"]
        onAccepted: {
            // Slected video file
            video.source = fileDialog.fileUrl
        }
    }

    // Make Video to play the video
    Video {
        id: video
        anchors.fill: parent
    }

    // Rectangle to display the video
    Rectangle {
        id: videoRectangle
        anchors.fill: parent
        color: "black"
        Item {
            id: videoItem
            width: video.width
            height: video.height
            visible: false
            focus: true
            VideoOutput {
                id: videoOutput
                anchors.fill: parent
                source: video
            }
        }
    }

    // Button to open the FileDialog
    Rectangle {
        id: openButton
        x: 20
        y: 20
        width: 100
        height: 50
        color: "blue"
        Text {
            text: "Open Video"
            anchors.centerIn: parent
            color: "white"
        }
        MouseArea {
            anchors.fill: parent
            onClicked: fileDialog.open()
        }
    }

    //  Slider to control the playback position of the video
    Rectangle {
        id: positionSlider
        x: 20
        y: 80
        width: 600
        height: 20
        color: "white"
        Rectangle {
            width: (video.position / video.duration) * parent.width
            height: parent.height
            color: "blue"
        }
        MouseArea {
            anchors.fill: parent
            onPositionChanged: {
                video.position = (mouseX / parent.width) * video.duration
            }
        }
    }

    // Button to play or pause the video
    Rectangle {
        id: playButton
        x: 20
        y: 110
        width: 100
        height: 50
        color: "blue"
        Text {
            text: video.playbackState == MediaPlayer.PlayingState ? "Pause" : "Play"
            anchors.centerIn: parent
            color: "white"
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                if (video.playbackState == MediaPlayer.PlayingState) {
                    video.pause()
                } else {
                    video.play()
                }
            }
        }
    }
}
