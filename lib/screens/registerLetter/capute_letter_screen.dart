import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:senia_app/main.dart';
import 'package:senia_app/models/models.dart';

class CaptureLetterScreeen extends StatefulWidget {
  CaptureLetterScreeen({Key? key}) : super(key: key);

  @override
  _CaptureLetterScreeenState createState() => _CaptureLetterScreeenState();
}

class _CaptureLetterScreeenState extends State<CaptureLetterScreeen> {
  late CameraImage cameraImage;
  late CameraController cameraController;
  bool isWorking = false;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  // @override
  // void dispose() {
  //   _closeCamera();
  //   super.dispose();
  // }

  @override
  void deactivate() {
    super.deactivate();
    print('ohhhh');
    _closeCamera();
  }

  _initCamera() {
    cameraController = CameraController(cameras[0], ResolutionPreset.high);
    cameraController.initialize().then((_) => {
          if (mounted)
            {
              setState(() {
                cameraController.startImageStream((imageFromStream) {
                  if (!isWorking) {
                    isWorking = true;
                    cameraImage = imageFromStream;
                  }
                });
              })
            }
        });
  }

  _closeCamera() {
    cameraController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final LetterModel letter =
        ModalRoute.of(context)?.settings.arguments as LetterModel;
    return Scaffold(
        appBar: AppBar(
          title: Text('Capturando letra - ${letter.name}'),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: _CaptureLetterFloatingsActionsButtons(),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Progreso: 50%'),
                SizedBox(height: 10),
                LinearProgressIndicator(
                  minHeight: 10,
                  value: 0.5,
                  semanticsLabel: 'asdas',
                ),
                SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  child: !cameraController.value.isInitialized
                      ? Container()
                      : Align(
                          alignment: Alignment.center,
                          child: CameraPreview(cameraController),
                        ),
                )
              ],
            ),
          ),
        ));
  }
}

class _CaptureLetterFloatingsActionsButtons extends StatelessWidget {
  const _CaptureLetterFloatingsActionsButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FloatingActionButton(
          onPressed: () {},
          tooltip: 'Tomar Foto',
          child: Icon(Icons.camera),
        ),
        SizedBox(width: 20),
        FloatingActionButton(
          onPressed: () {},
          tooltip: 'Girar cámara',
          child: Icon(Icons.camera_front),
        ),
      ],
    );
  }
}
