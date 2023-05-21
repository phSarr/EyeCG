import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';


class TakePicturePage extends StatefulWidget {
  final CameraDescription camera;
  TakePicturePage({required this.camera});

  @override
  _TakePicturePageState createState() => _TakePicturePageState();
}

class _TakePicturePageState extends State<TakePicturePage> {
  late CameraController _cameraController;
  late Future<void> _initializeCameraControllerFuture;

  @override
  void initState() {
    super.initState();

    _cameraController =
        CameraController(widget.camera, ResolutionPreset.medium);

    _initializeCameraControllerFuture = _cameraController.initialize();
  }

  void _takePicture(BuildContext context) async {
    try {
      await _initializeCameraControllerFuture;
      var file = await _cameraController.takePicture();
      var _name = (file.name);
      final path = join((await getTemporaryDirectory()).path, '$_name');
      //await io.File(file as String).rename(path); {DateTime.now()}.png
      Navigator.pop(context,path);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : Stack(children: <Widget>[
        Container(
          height: double.infinity,
          child: FutureBuilder(
            future: _initializeCameraControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return CameraPreview(_cameraController);
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
         Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: FloatingActionButton(
                backgroundColor: Colors.black,
                child: const Icon(Icons.camera, color: Colors.grey, size: 35,),
                onPressed: () {
                  _takePicture(context);
                },
              ),
            ),
          ),
      ]),
    );
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }
}
