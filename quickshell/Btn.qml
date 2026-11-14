import QtQuick

Rectangle {
  id: btn
  property string icon: ""
  property string accent: "#b48cff"
  property string fonte: "Iosevka Nerd Font"
  signal clicked()

  width: 34
  height: 28
  radius: 8
  color: area.containsMouse ? "#2a2150" : "#1c1636"
  Behavior on color { ColorAnimation { duration: 150 } }

  Text {
    anchors.centerIn: parent
    text: btn.icon
    color: btn.accent
    font.family: btn.fonte
    font.pixelSize: 16
  }

  MouseArea {
    id: area
    anchors.fill: parent
    hoverEnabled: true
    onClicked: btn.clicked()
  }
}
