import bb.system 1.0
import bb.cascades 1.0
import com.titanwallet 1.0

NavigationPane {
    id: nav
    property bool helpPagePushed
    property bool settingsPagePushed
    property variant camSheet
    
    property int defaultPadding: 21
    
    onPopTransitionEnded: {
        helpPagePushed = false
        settingsPagePushed = false
    }
    onCreationCompleted: {
        Qt.app = app
        Qt.dataSource = dataSource
    }
    
    Menu.definition: MenuDefinition {
        helpAction: HelpActionItem {
            onTriggered: {
                if (! helpPagePushed) {
                    helpPagePushed = true
                    nav.push(helpPageDef.createObject())
                }
            }
        }
        actions: [
            ActionItem {
                ActionBar.placement: ActionBarPlacement.OnBar
                title: "Share App"
                imageSource: "images/bbm.png"
                onTriggered: {
                    inviteToDownload.sendInvite();
                }
            }
        ]
    }

Page {
    actions: [
        ActionItem {
            title: "Scan"
            ActionBar.placement: ActionBarPlacement.OnBar
            onTriggered: {
                if (camSheet == null) {
                    camSheet = cameraSheet.createObject();
                }
                camSheet.camera.open()
                camSheet.open()
            }
        },
        ActionItem {
            title: "Add"
            imageSource: "images/add.png"
            ActionBar.placement: ActionBarPlacement.OnBar
            onTriggered: {
            
            }
        }
    ]
    Container {
        layout: DockLayout {}
        

        //Todo: fill me with QML
        ListView {
            leadingVisualSnapThreshold: 1
            dataModel: ArrayDataModel {
                id: myDataModel
            }
            onCreationCompleted: {
                dataSource.load();
            }
            listItemComponents: [
                ListItemComponent {
                    Label {
                        text: ListItemData.number
                    }
//                    ListItemContainer {
//                    
//                    }
                }
            ]
            attachedObjects: [
                CustomSqlDataSource {
                    id: dataSource
                    source: "sql/files.db"
                    query: "SELECT * FROM rewardCards"
                    onDataLoaded: {
                        myDataModel.clear();
                        myDataModel.append(data);
                    }
                }
            ]
        }
    }
}
attachedObjects: [
    ComponentDefinition {
        id: helpPageDef
        source: "help.qml"
    },
    ComponentDefinition {
        id: cameraSheet
        source: "CameraSheet.qml"
    }
]
}