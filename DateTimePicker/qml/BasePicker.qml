import QtQuick 2.3

PathView{
    id: spinner
    // public:

    function setCurrentIndex(index) {
        positionViewAtIndex(index, PathView.Center)
    }

    property int textHorizontalAlignment: Text.AlignHCenter
    property int textVerticalAlignment: Text.AlignVCenter

    // setting:
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

    delegate: Text {
        id: showItem
        width: spinner.width
        height: font.pixelSize*2
        horizontalAlignment: textHorizontalAlignment
        verticalAlignment: textVerticalAlignment
        text: model.modelData
        font.pixelSize: showItem.PathView.isCurrentItem ? 50 : 36
        color: showItem.PathView.isCurrentItem ? "#333333" : "#999999"
        MouseArea{
            anchors.fill: parent
            onReleased: {
                if(containsMouse){
                    setCurrentIndex(showItem.PathView.isCurrentItem ? (index + 1) : index)
                }
            }
        }
    }

//    Row {
//        x: 10; y: 10
//        spacing: 10

//        Text {
//            id: info
//            font.pointSize: 26
//            text: qsTr("text")
//        }
//        Text {
//            font.pointSize: 26
//            text: qsTr("text")
//            transform: Rotation { origin.x: info.paintedWidth/2; origin.y: info.paintedHeight/2.0; axis { x: 1; y: 0; z: 0 } angle: 18 }
//        }
//        Text {
//            font.pointSize: 26
//            text: qsTr("text")
//            transform: Rotation { origin.x: info.paintedWidth/2; origin.y: info.paintedHeight/2.0; axis { x: 1; y: 0; z: 0 } angle: 36 }
//        }
//        Text {
//            font.pointSize: 26
//            text: qsTr("text")
//            transform: Rotation { origin.x: info.paintedWidth/2; origin.y: info.paintedHeight/2.0; axis { x: 1; y: 0; z: 0 } angle: 54 }
//        }
//        Text {
//            font.pointSize: 26
//            text: qsTr("text")
//            transform: Rotation { origin.x: info.paintedWidth/2; origin.y: info.paintedHeight/2.0; axis { x: 1; y: 0; z: 0 } angle: 72 }
//        }
//    }
}
