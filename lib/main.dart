import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:gallery_app/camera/camera.dart';
void main() => runApp(MyApp());
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Gallery App')),
        backgroundColor: Colors.deepPurple,
      ),

      body: screen,

      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
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
            setState(() => screen = Camera());
          }
          // Here else is used so that screen doesn't remain on camera
          // even after any other button is selected
          // set the screen in accordance to requirement
          else {
            setState(() => screen = Container());
          }
        },
      ),
    );
  }
}