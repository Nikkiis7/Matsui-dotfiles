import Quickshell
import Quickshell.Wayland
import QtQuick

PanelWindow {
  WlrLayershell.layer: WlrLayer.Background
  exclusionMode: ExclusionMode.Ignore

  anchors {
    bottom: true
    left: true
  }
  margins {
    bottom: 60
    left: 60
  }

  implicitWidth: 520
  implicitHeight: 140
  color: "transparent"

  SystemClock {
    id: clock
    precision: SystemClock.Seconds
  }

  Column {
    anchors.left: parent.left
    anchors.verticalCenter: parent.verticalCenter
    spacing: 4

    Text {
      text: Qt.formatDateTime(clock.date, "HH:mm:ss")
      color: "#b48cff"
      font.family: "Iosevka Nerd Font"
      font.pixelSize: 80
      font.weight: Font.Light
    }

    Text {
      text: clock.date.toLocaleDateString(Qt.locale("ja_JP"), "yyyy年M月d日 dddd")
      color: "#b48cff"
      font.family: "Iosevka Nerd Font"
      font.pixelSize: 20
    }
  }
}
