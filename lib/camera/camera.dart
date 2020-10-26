import 'package:camera/camera.dart';
import 'package:gallery_app/main.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class Camera extends StatefulWidget {
  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  CameraController camController;
  int _camIndex = 0;

  Widget _cam() {
    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / size.height;

     if (!camController.value.isInitialized) {
      return Container();
    }
    return Transform.scale(
      scale: camController.value.aspectRatio / deviceRatio,
      child: Center(
        child: AspectRatio(
          aspectRatio: camController.value.aspectRatio,
          child: CameraPreview(camController),
        ),
      ),
    );
  }

  Widget _camButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          icon: Icon(Icons.flash_auto,size: 35),
          color: Colors.white,
          onPressed: (){},
        ),
        GestureDetector(
          onTap: _clickPicture,
          child: Container(
            height: 200.0,
            width: 100.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              //color: Colors.white,
              border: Border.all(
                color: Colors.white,
                width: 5.0,
              ),
            ),
          ),
        ),
        IconButton(                           // <-- Switch camera
          color: Colors.white,
          icon: Icon(Icons.flip_camera_ios,size: 35),
          onPressed: _changeCamera,
        ),
      ],
    );
  }

  void _clickPicture() async {
    try {

      final imgPath = path.join((await getTemporaryDirectory()).path, '${DateTime.now()}.png');

      camController.takePicture(imgPath);


    }catch(e){
      print(e);
    }
  }

  void _changeCamera() {
     if (camController == null ||
        !camController.value.isInitialized ||
        camController.value.isTakingPicture) {
      return;
    }
    final newIndex = _camIndex + 1 == cameras.length ? 0 : _camIndex += 1;
    _initCamera(newIndex);
  }

  void _initCamera(index){
    camController = CameraController(cameras[index], ResolutionPreset.high);
    camController.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {
        _camIndex = index;
      });
    });
  }
  
  @override
  void initState() {
    super.initState();
    _initCamera(_camIndex);
  }

  @override
  void dispose() {
    camController?.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _cam(),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _camButtons(),
          ],
        ),
      ],
    );
  }
}