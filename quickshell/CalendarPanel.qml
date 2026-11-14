import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import QtQuick

PanelWindow {
  id: win

  IpcHandler {
    target: "calendar"
    function toggle(): void {
      if (!win.open) win.goToday()
      win.open = !win.open
    }
  }

  SystemClock {
    id: clock
    precision: SystemClock.Minutes
  }

  property bool open: false
  property bool shown: open

  property string accent: "#b48cff"
  property string fonte: "Iosevka Nerd Font"

  property var meses: ["Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho",
                       "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"]
  property var dias: ["D", "S", "T", "Q", "Q", "S", "S"]

  property int viewYear: new Date().getFullYear()
  property int viewMonth: new Date().getMonth()
  property int firstOffset: new Date(viewYear, viewMonth, 1).getDay()

  function goToday() {
    const d = new Date()
    viewYear = d.getFullYear()
    viewMonth = d.getMonth()
  }

  function shift(n) {
    const d = new Date(viewYear, viewMonth + n, 1)
    viewYear = d.getFullYear()
    viewMonth = d.getMonth()
  }

  visible: shown || card.opacity > 0.01

  WlrLayershell.layer: WlrLayer.Top
  WlrLayershell.keyboardFocus: win.shown ? WlrKeyboardFocus.Exclusive : WlrKeyboardFocus.None
  exclusionMode: ExclusionMode.Ignore

  anchors {
    top: true
    right: true
  }
  margins {
    top: 66
    right: 63
  }

  implicitWidth: 294
  implicitHeight: 290
  color: "transparent"

  Item {
    anchors.fill: parent
    focus: true
    Keys.onEscapePressed: win.open = false
  }

  Rectangle {
    id: card
    width: parent.width
    height: 284
    radius: 10
    color: "#f2100c20"
    border.color: "#2e2650"
    border.width: 1

    opacity: win.shown ? 1 : 0
    Behavior on opacity { NumberAnimation { duration: 450; easing.type: Easing.OutCubic } }

    transform: Translate {
      y: win.shown ? 0 : -28
      Behavior on y { NumberAnimation { duration: 450; easing.type: Easing.OutCubic } }
    }

    Column {
      anchors.fill: parent
      anchors.margins: 14
      spacing: 8

      Item {
        width: parent.width
        height: 28

        Btn {
          anchors.left: parent.left
          icon: "󰅁"
          accent: win.accent
          fonte: win.fonte
          onClicked: win.shift(-1)
        }

        Text {
          anchors.centerIn: parent
          text: win.meses[win.viewMonth] + " " + win.viewYear
          color: "#e8e2ff"
          font.family: win.fonte
          font.pixelSize: 14
          font.bold: true

          MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: win.goToday()
          }
        }

        Btn {
          anchors.right: parent.right
          icon: "󰅂"
          accent: win.accent
          fonte: win.fonte
          onClicked: win.shift(1)
        }
      }

      Row {
        Repeater {
          model: 7
          Text {
            width: 38
            height: 20
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: win.dias[index]
            color: "#9b92b8"
            font.family: win.fonte
            font.pixelSize: 12
          }
        }
      }

      Grid {
        columns: 7

        Repeater {
          model: 42

          Rectangle {
            id: cell
            width: 38
            height: 32
            radius: 8

            property var cellDate: new Date(win.viewYear, win.viewMonth, 1 - win.firstOffset + index)
            property bool inMonth: cellDate.getMonth() === win.viewMonth
            property bool isToday: cellDate.getFullYear() === clock.date.getFullYear()
                                && cellDate.getMonth() === clock.date.getMonth()
                                && cellDate.getDate() === clock.date.getDate()

            color: isToday ? win.accent : (cellArea.containsMouse ? "#2a2150" : "transparent")
            Behavior on color { ColorAnimation { duration: 120 } }

            Text {
              anchors.centerIn: parent
              text: cell.cellDate.getDate()
              color: cell.isToday ? "#100c20" : (cell.inMonth ? "#e8e2ff" : "#5b5478")
              font.family: win.fonte
              font.pixelSize: 13
              font.bold: cell.isToday
            }

            MouseArea {
              id: cellArea
              anchors.fill: parent
              hoverEnabled: true
            }
          }
        }
      }
    }
  }
}
