import QtQuick

Item {
  id: root
  property var player: null
  property string accent: "#b48cff"
  property bool dragging: false
  property real dragRatio: 0

  height: 3

  readonly property real ratio: {
    if (dragging) return dragRatio
    if (player && player.length > 0)
      return Math.min(1, Math.max(0, player.position / player.length))
    return 0
  }

  Rectangle {
    id: track
    anchors.verticalCenter: parent.verticalCenter
    width: parent.width
    height: (area.containsMouse || root.dragging) ? 5 : 3
    radius: 3
    color: "#2a2150"
    Behavior on height { NumberAnimation { duration: 120 } }

    Rectangle {
      height: parent.height
      radius: 3
      color: root.accent
      width: parent.width * root.ratio
    }

    Rectangle {
      visible: area.containsMouse || root.dragging
      width: 10
      height: 10
      radius: 5
      color: root.accent
      anchors.verticalCenter: parent.verticalCenter
      x: Math.max(0, Math.min(parent.width - width, parent.width * root.ratio - width / 2))
    }
  }

  // área de clique maior que a linha visível
  MouseArea {
    id: area
    anchors.fill: parent
    anchors.topMargin: -7
    anchors.bottomMargin: -7
    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor

    function setRatio(mx) {
      root.dragRatio = Math.max(0, Math.min(1, mx / width))
    }

    onPressed: (m) => {
      root.dragging = true
      setRatio(m.x)
    }
    onPositionChanged: (m) => {
      if (pressed) setRatio(m.x)
    }
    onReleased: {
      if (root.player && root.player.canSeek && root.player.length > 0)
        root.player.position = root.dragRatio * root.player.length
      root.dragging = false
    }
  }
}
