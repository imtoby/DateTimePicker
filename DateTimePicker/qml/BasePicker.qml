import QtQuick 2.3

PathView{
    id: spinner
    // public:
    property int textHorizontalAlignment: Text.AlignHCenter
    property int textVerticalAlignment: Text.AlignVCenter

    function setCurrentIndex(index) {
        positionViewAtIndex(index, PathView.Center)
    }

    implicitWidth: 240
    implicitHeight: parent.height
    pathItemCount: 5
    preferredHighlightBegin: 0.5
    preferredHighlightEnd: 0.5
    highlightRangeMode: PathView.StrictlyEnforceRange
    snapMode: PathView.SnapToItem
    flickDeceleration: 500

    path: Path{
        startX: spinner.width/2; startY: 0;
        PathLine { x: spinner.width/2; y: spinner.height }
    }

    delegate: Item {
        id: showItem
        width: spinner.width
        height: info.font.pointSize * 2

//        Rectangle { // MouseArea visible Area
//            anchors.fill: parent
//            color: "transparent"
//            border.color: "red"
//        }

        Text {
            id: info
            anchors.centerIn: parent

            horizontalAlignment: textHorizontalAlignment
            verticalAlignment: textVerticalAlignment
            text: model.modelData
            font.pointSize: showItem.PathView.isCurrentItem ? 26 : 16
            color: showItem.PathView.isCurrentItem ? "#333333" : "#999999"
            transform: Rotation {
                origin.x: info.paintedWidth/2
                origin.y: info.paintedHeight/2.0
                axis { x: 1; y: 0; z: 0 }
                angle: {
                    if (showItem.PathView.view.currentIndex === index) {
                        return 0
                    } else if (showItem.PathView.view.currentIndex
                               === index - 1) {
                        return -40
                    } else if (showItem.PathView.view.currentIndex
                               === index - 2) {
                        return -70
                    } else if (showItem.PathView.view.currentIndex
                               === index + 1) {
                        return 40
                    } else if (showItem.PathView.view.currentIndex
                               === index + 2) {
                        return 70
                    }
                    return -50
                }
            }
        }

        MouseArea{
            anchors.fill: parent
            onReleased: {
                if(containsMouse){
                    setCurrentIndex(showItem.PathView.isCurrentItem ?
                                        (index + 1) : index)
                }
            }
        }
    }

}
