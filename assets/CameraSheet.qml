import bb.cascades 1.0
import bb.cascades.multimedia 1.0
import bb.multimedia 1.0

Sheet {
    property alias camera: camera
    Page {
        titleBar: TitleBar {
            title: ""
            dismissAction: ActionItem {
                title: "Close"
                onTriggered: {
                    close()
                }
            }
            kind: TitleBarKind.Default
        }
        Container {
            Camera {
                id: camera
                horizontalAlignment: HorizontalAlignment.Fill
                verticalAlignment: VerticalAlignment.Fill

                onCameraOpened: {
                    // Apply some settings after the camera was opened successfully
                    getSettings(cameraSettings)
                    cameraSettings.focusMode = CameraFocusMode.ContinuousAuto
                    cameraSettings.shootingMode = CameraShootingMode.Stabilization
                    applySettings(cameraSettings)

                    // Start the view finder as it is needed by the barcode detector
                    camera.startViewfinder()
                }
                attachedObjects: [
                    BarcodeDetector {
                        id: barcodeDetector
                        camera: camera
                        formats: BarcodeFormat.Any
                        onDetected: {
                            scannedSound.play()
                            camera.close();
                            Qt.dataSource.executeAndWait("INSERT INTO rewardCards (number) VALUES (?)", [data]);
                            dataSource.load()
                            camSheet.close();
                        }
                    },
                    SystemSound {
                        id: scannedSound

                        sound: SystemSound.GeneralNotification
                    },
                    CameraSettings {
                        id: cameraSettings
                    }
                ]
            }
        }
    }
}
