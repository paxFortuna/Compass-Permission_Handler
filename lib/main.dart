import 'package:compass_koko/neu_circle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:math' as math;
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
      if (mounted) {
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
      backgroundColor: Colors.brown[600],
      body: SafeArea(
        child: Builder(
          builder: (cotext) {
            if (_hasPermissions) {
              return _buildCompass();
            } else {
              return _buildPermissionSheet();
            }
          },
        ),
      ),
    ));
  }

  // compass widget
  // compileSdkVersion 33, minSdkVersion 23 & add permission_example
  Widget _buildCompass() {
    return StreamBuilder(
        stream: FlutterCompass.events,
        builder: (context, snapshot) {
          // error msg
          if (snapshot.hasError) {
            return Text(
              'Error reading heading: ${snapshot.error}',
            );
          }
          // loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          double? direction = snapshot.data!.heading;

          // if direction is null, then device does not support this sensor
          if (direction == null) {
            return const Center(
              child: Text('Device does not have sensors'),
            );
          }

          // return compass
          return NeuCircle(
            child: Center(
              child: Container(
                //margin: const EdgeInsets.only(top: 2),
                padding: const EdgeInsets.only(left: 25, right: 12, top: 15, bottom: 15),
                child: Transform.rotate(
                  angle: direction * (math.pi / 180) - 1,
                  child: Image.asset(
                    'assets/compass.png',
                    color: Colors.white
                    ,
                  ),
                ),
              ),
            ),
          );
        });
  }

  // permission sheet widget : 인증 요구 버튼
  Widget _buildPermissionSheet() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Permission.locationWhenInUse.request().then((value) {
            _fetchPermissionStatus();
          });
        },
        child: const Text('Request Permission'),
      ),
    );
  }
}
