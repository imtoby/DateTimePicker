import QtQuick 2.3

Item {
    id: timePositioner
    objectName: "TimePositioner"

    readonly property alias count: repeater.count
    readonly property real xPos: width/2.0
    readonly property real yPos: 0
    readonly property real r: width/2.0
    property alias model: repeater.model
    property int currentIndex: repeater.currentIndex
    property real angle: 2.0*Math.PI/repeater.count

    onCurrentIndexChanged: {
        if(timePositioner.currentIndex !== repeater.currentIndex){
            repeater.currentIndex = timePositioner.currentIndex
        }
    }


    Item {
        width: Math.min(parent.width, parent.height)
        height: width
        anchors.centerIn: parent

        Repeater{
            id: repeater
            model: 12
            property int currentIndex: -1
            onCurrentIndexChanged: {
                if(timePositioner.currentIndex !== repeater.currentIndex){
                    timePositioner.currentIndex = repeater.currentIndex
                }
            }

            Item{
                width: 1
                height: 1
                x: xPos + Math.sin(angle*index)*r
                y: yPos + (1-Math.cos(angle*index))*r

                Item{
                    width: timePositioner.width*2/repeater.count
                    height: 200
                    anchors.centerIn: parent
                    rotation: index%(repeater.count/2) * (360/repeater.count)

                    DropArea {
                        id: dropArea
                        anchors.fill: parent
                        onEntered: {
                            repeater.currentIndex = index
                        }
                    }

                    Item {
                        width: timePositioner.width*2/repeater.count
                        height: timePositioner.width*2/repeater.count
                        x: (parent.width - width)/2
                        y: (parent.height - height)/2
                        Drag.active: dragArea.drag.active

                        function resetPos(){
                            x = (parent.width - width)/2
                            y = (parent.height - height)/2
                        }

                        MouseArea {
                            id: dragArea
                            anchors.fill: parent
                            drag.target: parent
                            onClicked: {
                                repeater.currentIndex = index
                            }

                            onReleased: {
                                parent.resetPos()
                            }

                            onCanceled: {
                                parent.resetPos()
                            }
                        }
                    }
                }


                Rectangle{
                    id: colorR
                    width: 2
                    height: r
                    antialiasing: true
                    transformOrigin: Rectangle.Top
                    visible: currentIndex === index
                    rotation: index%(repeater.count) * (360/repeater.count)
                    color: "#884444"
                }

                Rectangle{
                    width: timePositioner.width*3/repeater.count
                    height: width
                    anchors.centerIn: parent
                    radius: width/2
                    visible: currentIndex === index
                    color: "#884444"
                }

                Text {
                    id: content
                    text: index ? index : index + repeater.count
                    anchors.centerIn: parent
                    font.pixelSize: 20
                }
            }
        }
    }

}
