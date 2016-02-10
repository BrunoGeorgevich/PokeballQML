import QtQuick 2.4
import QtQuick.Controls 1.3

ApplicationWindow {
    title: qsTr("Hello World")
    width: 640
    height: 480
    visible: true

    Pokeball {
        color:"transparent"
        //width: parent.width/4; height: parent.height/4
        //anchors { bottom:parent.bottom; right:parent.right }
        anchors.fill:parent
    }
}
