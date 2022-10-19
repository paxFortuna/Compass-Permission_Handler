import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _hasPermissions = false;

  @override
  void initState() {
    _fetchPermissionStatus();
    super.initState();
  }

  _fetchPermissionStatus() {
    Permission.locationWhenInUse.status.then((status) {
      if(mounted){
        setState(() {
          _hasPermissions = (status == PermissionStatus.granted);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // backgroundColor: Colors.brown[700]),
        body: SafeArea(
          child: Builder(
            builder: (cotext) {
              if(_hasPermissions){
                return _buildCompass();
              } else {
                return _buildPermissionSheet();
              }
            },
          ),
        ),
      )
    );
  }

  // compass widget
  // compileSdkVersion 33, minSdkVersion 23 & add permission_example
  Widget _buildCompass(){
    return Container(
      margin: const EdgeInsets.only(top: 62),
      child: Image.asset('assets/compass.png'),
    );
  }

  // permission sheet widget
  Widget _buildPermissionSheet(){
    return Center(
      child: ElevatedButton(
        onPressed: (){
          Permission.locationWhenInUse.request().then((value) {
            _fetchPermissionStatus();
          });
        }, child: const Text('Request Permission'),
      ),
    );
  }

}