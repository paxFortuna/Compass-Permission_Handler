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
  _buildCompass(){

  }
  _buildPermission(){

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // backgroundColor: Colors.brown[700]),
        body: Builder(
          builder: (cotext) {
            if(_hasPermissions){
              return _buildCompass();
            } else {
              return _buildPermission();
            }
          },
        ),
      )
    );
  }
}