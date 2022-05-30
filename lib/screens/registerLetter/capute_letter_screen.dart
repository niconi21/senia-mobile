import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senia_app/configs/configs.dart';
import 'package:senia_app/main.dart';
import 'package:senia_app/models/models.dart';
import 'package:senia_app/providers/image_provider.dart';
import 'package:senia_app/providers/providers.dart';

class CaptureLetterScreeen extends StatefulWidget {
  CaptureLetterScreeen({Key? key}) : super(key: key);

  @override
  _CaptureLetterScreeenState createState() => _CaptureLetterScreeenState();
}

class _CaptureLetterScreeenState extends State<CaptureLetterScreeen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  bool _isLoading = false;
  bool _flashOn = false; // 0 Apagado - 1 Encendido
  int _numCamera = 0;
  double _progressImages = 0;
  LetterModel letter = LetterModel.empty();
  @override
  void initState() {
    super.initState();
    this._initCamera();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void deactivate() {
    _controller.dispose();
    super.deactivate();
  }

  void _initCamera({int numCamera = 0}) {
    this._controller =
        CameraController(cameras[numCamera], ResolutionPreset.medium);
    this._initializeControllerFuture = this._controller.initialize();
  }

  @override
  Widget build(BuildContext context) {
    final imageProvider = Provider.of<ImagenProvider>(context);
    final uiProvider = Provider.of<UiProvider>(context);

    letter = uiProvider.letterRegister;
    this._progressImages = letter.percentage;

    return Scaffold(
      appBar: AppBar(
        title: Text('Capturando letra - ${letter.name}'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _CaptureLetterFloatingsActionsButtons(
        isLoading: _isLoading,
        flashOn: _flashOn,
        onPressedCapture: () async {
          setState(() {
            this._isLoading = true;
          });
          try {
            if (true) {
              await _initializeControllerFuture;
              await _controller.setFocusMode(FocusMode.auto);
              final image = await _controller.takePicture();

              final resp = await imageProvider.loadImage(letter.id, image.path);
              if (resp.ok) {
                setState(() {
                  uiProvider.letterRegister = resp.result.letter!;
                  // this._progressImages = resp.result.letter!.percentage;
                });
              }
            }

            setState(() {
              this._isLoading = false;
            });
          } on CameraException catch (cameraErr) {
            print(cameraErr);
            setState(() {
              this._isLoading = false;
            });
          } on FormatException catch (formatErr) {
            print(formatErr);
            setState(() {
              this._isLoading = false;
            });
          }
          ;
          // } catch (e) {
          //   final ex = e as CameraException;
          // }
        },
        onPressedChange: () async {
          await _controller.dispose();
          _numCamera = _numCamera == 0 ? 1 : 0;
          setState(() {
            _initCamera(numCamera: _numCamera);
          });
        },
        onPressedFlash: () async {
          _flashOn = !_flashOn;

          await _controller
              .setFlashMode(!_flashOn ? FlashMode.torch : FlashMode.off);
          setState(() {});
        },
      ),
      body: FutureBuilder(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              letter.percentage != 100) {
            _controller.setFlashMode(FlashMode.off);
            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Progreso: $_progressImages%'),
                    SizedBox(height: 10),
                    LinearProgressIndicator(
                      minHeight: 10,
                      value: _progressImages / 100,
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      child: CameraPreview(_controller),
                    )
                  ],
                ),
              ),
            );
          } else {
            if (letter.percentage == 100) {
              cerrarTodo(context);
            }

            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  void cerrarTodo(BuildContext context) async {
    await _controller.dispose();
    Navigator.popAndPushNamed(context, AppRoutes.routesApp['home']!.route);
  }
}

class _CaptureLetterFloatingsActionsButtons extends StatelessWidget {
  void Function()? onPressedCapture;
  void Function()? onPressedChange;
  void Function()? onPressedFlash;
  bool isLoading;
  bool flashOn;
  _CaptureLetterFloatingsActionsButtons({
    Key? key,
    required this.onPressedCapture,
    required this.onPressedChange,
    required this.onPressedFlash,
    required this.isLoading,
    required this.flashOn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FloatingActionButton(
          onPressed: !isLoading ? onPressedCapture : null,
          tooltip: 'Tomar Foto',
          child: !isLoading
              ? Icon(Icons.camera)
              : CircularProgressIndicator(
                  color: Colors.white,
                ),
          heroTag: 'TomarFotoTag',
        ),
        SizedBox(width: 20),
        FloatingActionButton(
          onPressed: !isLoading ? onPressedChange : null,
          tooltip: 'Girar cámara',
          child: Icon(Icons.camera_front),
          heroTag: 'GirarCamaraTag',
        ),
        SizedBox(width: 20),
        FloatingActionButton(
          onPressed: !isLoading ? onPressedFlash : null,
          tooltip: !flashOn ? 'Apagar Flash' : 'Encender Flash',
          child: !flashOn ? Icon(Icons.flash_off) : Icon(Icons.flash_on),
          heroTag: 'EncenderFlashTag',
        ),
      ],
    );
  }
}
