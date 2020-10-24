import 'package:camera/camera.dart';
import 'package:gallery_app/main.dart';
import 'package:flutter/material.dart';

class Camera extends StatefulWidget {
  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  CameraController camController;
  
  @override
  void initState() {
    super.initState();
    camController = CameraController(cameras[0], ResolutionPreset.medium);
    camController.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    camController?.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    
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
}