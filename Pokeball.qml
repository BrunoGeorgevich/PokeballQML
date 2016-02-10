import QtQuick 2.0

Rectangle {
    id:pokeballRoot

    signal capturing
    function start() { state="capturing" }
    function stop() { state="normal" }
    property string upSideColor : "Red"
    property string bottomSideColor : "White"
    property string majorCentralCircleColor : "White"
    property string minorCentralCircleColorNormal : "Black"
    property string minorCentralCircleColorCapturing : "yellow"
    property string lineColor : "Black"
    property var defaultAngle : 25
    property var rotateVelocity : 70

    state:"normal"

    Item {
        id:pokeball
        anchors.centerIn: parent
        width: parent.width/2; height:width
        transform: Rotation {
            id:rotationCenterRect
            axis { x:0;y:0;z:1 }
            angle:0

            origin.x:pokeballRoot.width/4
            origin.y:pokeballRoot.height*0.6
        }

        Canvas {
            anchors.fill: parent
            onPaint: {
                var ctx = getContext("2d");
                ctx.reset();

                var centreX = width / 2;
                var centreY = height / 2;

                ctx.strokeStyle = lineColor
                ctx.lineWidth = pokeballRoot.height/60;

                //Draw the red arc
                ctx.beginPath();
                ctx.fillStyle = upSideColor;
                ctx.moveTo(centreX, centreY);
                ctx.arc(centreX, centreY, width*(0.485) , 0, Math.PI, true);
                ctx.lineTo(centreX, centreY);
                ctx.fill();
                ctx.stroke();

                //Draw the white arc
                ctx.beginPath();
                ctx.fillStyle = bottomSideColor;
                ctx.arc(centreX, centreY, width*(0.485), Math.PI, 2*Math.PI, true);
                ctx.fill();
                ctx.stroke();

                //Draw Central Line
                ctx.beginPath();
                ctx.lineWidth = pokeballRoot.height/20;
                ctx.moveTo(0+pokeball.width/100,centreY);
                ctx.lineTo(pokeball.width*0.99,centreY);
                ctx.stroke();

                //The major central circle
                ctx.beginPath();
                ctx.lineWidth = pokeballRoot.height/60;
                ctx.fillStyle = majorCentralCircleColor;
                ctx.arc(centreX, centreY, width / 8, 0, 2*Math.PI, true);
                ctx.fill();
                ctx.stroke();
            }
            Rectangle {
                id:centralCircle
                anchors.centerIn: parent
                width: parent.width/8
                height: width
                radius: width/2
                color:minorCentralCircleColorNormal
                SequentialAnimation on color {
                    id:colorBlink
                    running:false
                    loops:Animation.Infinite
                    ColorAnimation {
                        from: minorCentralCircleColorNormal
                        to: minorCentralCircleColorCapturing
                        duration: 600
                    }
                    ColorAnimation {
                        target:centralCircle; property:"color"
                        from: minorCentralCircleColorCapturing
                        to: minorCentralCircleColorNormal
                        duration: 600
                    }
                }
            }
        }
    }

    states: [
        State {
            name: "normal"
            PropertyChanges {
                target:colorBlink
                running:false
            }
            PropertyChanges {
                target:rotationCenterRect
                angle : 0
            }
        },
        State {
            name: "capturing"
            PropertyChanges {
                target:colorBlink
                running:true
            }
        }
    ]

    transitions: [
        Transition {
            from: "normal"
            to: "capturing"
            ParallelAnimation {
                loops: Animation.Infinite
                SequentialAnimation {
                    SmoothedAnimation {
                        target:rotationCenterRect
                        property: "angle"
                        from:-defaultAngle
                        to: defaultAngle
                        velocity: rotateVelocity
                    }
                    SmoothedAnimation {
                        target:rotationCenterRect
                        property: "angle"
                        from:defaultAngle
                        to: -defaultAngle
                        velocity: rotateVelocity
                    }
                }
            }
        },
        Transition {
            from: "capturing"
            to: "normal"
            SmoothedAnimation {
                target:rotationCenterRect
                property: "angle"
                to: 0
                velocity: rotateVelocity
            }
            PropertyAction {
                target:centralCircle
                property: "color"
                value:minorCentralCircleColorNormal
            }
        }
    ]
}
