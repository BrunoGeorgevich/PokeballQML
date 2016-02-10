import QtQuick 2.4
import QtQuick.Controls 1.3

ApplicationWindow {
    title: qsTr("Hello World")
    width: 640
    height: 480
    visible: true

    Pokeball {
        id:poke
        color:"transparent"
        width: parent.width/4; height: parent.height/4
        anchors { top:parent.top; right:parent.right }
        upSideColor: "#09A"
    }
    Pokeball {
        id:poke2
        color:"transparent"
        width: parent.width/4; height: parent.height/4
        anchors { top:parent.top; left:parent.left }
        upSideColor: "#90A"
    }
    Pokeball {
        id:poke3
        color:"transparent"
        width: parent.width/4; height: parent.height/4
        anchors { bottom:parent.bottom; right:parent.right }
        upSideColor: "#092"
    }
    Pokeball {
        id:poke4
        color:"transparent"
        width: parent.width/4; height: parent.height/4
        anchors { bottom:parent.bottom; left:parent.left }
        upSideColor: "#AA0"
    }
    Pokeball {
        id:pokeCenter
        color:"transparent"
        width: parent.width*0.7; height: parent.height*0.7
        anchors.centerIn:parent
    }

    Component.onCompleted: { poke.start();poke2.start();poke3.start();poke4.start(); pokeCenter.start() }
}
