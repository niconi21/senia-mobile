import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:senia_app/configs/app_theme.dart';
import 'package:senia_app/main.dart';
import 'package:tflite/tflite.dart';

class ReadLsmScreen extends StatefulWidget {
  const ReadLsmScreen({Key? key}) : super(key: key);

  @override
  State<ReadLsmScreen> createState() => _ReadLsmScreenState();
}

class _ReadLsmScreenState extends State<ReadLsmScreen> {
  //instancias para la cámara
  late CameraImage cameraImage;
  late CameraController cameraController;
  bool isWorking = false;
  String result = '';
  @override
  void initState() {
    super.initState();
    _initCamera();
    _loadModel();
  }

  @override
  void dispose() async {
    _closeActivity();
    super.dispose();
  }

  _initCamera() {
    cameraController = CameraController(cameras[1], ResolutionPreset.medium);
    cameraController.initialize().then((_) => {
          if (mounted)
            {
              setState(() {
                cameraController.startImageStream((imageFromStream) {
                  if (!isWorking) {
                    isWorking = true;
                    cameraImage = imageFromStream;
                    _runModelOnFrame();
                  }
                });
              })
            }
        });
  }

  _runModelOnFrame() async {
    try {
      // ignore: unnecessary_null_comparison
      if (cameraImage != null) {
        var reconigtions = await Tflite.runModelOnFrame(
            bytesList: cameraImage.planes.map((plane) => plane.bytes).toList(),
            imageHeight: cameraImage.height,
            imageWidth: cameraImage.width,
            imageMean: 127.5,
            imageStd: 127.5,
            rotation: 90,
            numResults: 3,
            threshold: 0.1,
            asynch: true);
        result = '';

        reconigtions?.forEach((response) {
          result = response['label'] + ' - ';
        });
        setState(() {});
        isWorking = false;
      }
    } catch (error) {}
  }

  _loadModel() async {
    try {
      await Tflite.loadModel(
          model: 'assets/lsmModel.tflite',
          labels: 'assets/labels.txt',
          isAsset: true,
          useGpuDelegate: true);
    } catch (e) {}
  }

  _closeActivity() async {
    await Tflite.close();
    await cameraController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            result == ''
                ? 'Enfoca a la persona para iniciar detección'
                : 'Letras reconocidas: $result',
            style: TextStyle(color: AppTheme.accentColor)),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                _closeActivity();
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.cancel,
                color: AppTheme.dangerColor,
              ))
        ],
      ),
      body: Container(
        color: AppTheme.backgroundColor,
        child: !cameraController.value.isInitialized
            ? Container()
            : Align(
                alignment: Alignment.center,
                child: CameraPreview(cameraController),
              ),
      ),
    );
  }
}
