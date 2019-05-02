import QtQuick 2.0
import QtQuick.Layouts 1.1
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.extras 2.0 as PlasmaExtras

Item {

    PlasmaCore.IconItem {
        source: root.state === "playing" ? "media-playback-paused" :
                                           root.state === "paused" ?  "media-playback-playing" :
                                                                     "media-playback-stopped"
        active: compactMouse.containsMouse
        
        width:24
        height:24
        anchors.verticalCenter : parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter

        
    }
    MouseArea {
        id: compactMouse
        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.LeftButton | Qt.MiddleButton | Qt.BackButton | Qt.ForwardButton

        onWheel: {
            var service = mpris2Source.serviceForSource(mpris2Source.current)
            var operation = service.operationDescription("ChangeVolume")
            operation.delta = (wheel.angleDelta.y / 120) * 0.03
            operation.showOSD = true
            service.startOperationCall(operation)
        }

        onClicked: {
            switch (mouse.button) {
            case Qt.MiddleButton:
                root.togglePlaying()
                break
            case Qt.BackButton:
                root.action_previous()
                break
            case Qt.ForwardButton:
                root.action_next()
                break
            default:
                plasmoid.expanded = !plasmoid.expanded
            }
        }
    }
}
