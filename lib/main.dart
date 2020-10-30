import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:gallery_app/camera/camera.dart';

List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initializing the available cameras list
  // If any errors occurs they will be printed.
  try {
  cameras = await availableCameras();
  }
  on CameraException catch(e){
    print(e);
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Bottom Navigation Bar Demo",
        debugShowCheckedModeBanner: false,
        home: MyBottomNavigationBarDemo());
  }
}
class MyBottomNavigationBarDemo extends StatefulWidget {
  @override
  _MyBottomNavigationBarDemoState createState() =>
      _MyBottomNavigationBarDemoState();
}
class _MyBottomNavigationBarDemoState extends State<MyBottomNavigationBarDemo> {

  // This variable will display the screen according to
  // the item selected in the bottom Navigation bar
  // Set this variable in accordance to the option selected
  Widget screen;
  bool _camScreen = false; // for whether camera screen is selected or not

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // appBar will be visible only at the images and videos screen
      // No appBar will be present during the camera screen
      appBar: _camScreen
      ? null      
      : AppBar(
        title: Center(child: Text('Gallery App')),
        backgroundColor: Colors.deepPurple,
      ),

      body: screen,

      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: Colors.deepPurple,
        buttonBackgroundColor: Colors.deepPurple,
        height: 60,
        animationDuration: Duration(
          milliseconds: 200,
        ),
        index: 1,
        animationCurve: Curves.bounceInOut,
        items: <Widget>[
          Icon(Icons.video_collection_rounded, size: 30, color: Colors.white),
          Icon(Icons.image_sharp, size: 30, color: Colors.white),
          Icon(Icons.camera_alt_outlined, size: 30, color: Colors.white),
        ],
        onTap: (index) {
          if(index == 2) {
            setState((){
              screen = Camera();
              _camScreen = true;
              });
          }
          // Here else is used so that screen doesn't remain on camera
          // even after any other button is selected
          // set the screen in accordance to requirement

          // Note: Set the _camScreen bool to false whenever calling any screen other than camera screen
          else {
            setState((){
            _camScreen = false;  
            screen = Container();
            });
          }
        },
      ),
    );
  }
}