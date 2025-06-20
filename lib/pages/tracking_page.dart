import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:proyecto_dispomoviles/entity/profile.dart' as p;
import 'package:proyecto_dispomoviles/pages/pages_manager.dart';
import 'package:proyecto_dispomoviles/widgets/texts_style.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TrackingPage extends StatefulWidget {
  const TrackingPage({super.key, required this.i});

  final int i;

  @override
  State<TrackingPage> createState() => _TrackingPageState();
}

class _TrackingPageState extends State<TrackingPage> {

  static const Duration _ignoreDuration = Duration(milliseconds: 20);

  UserAccelerometerEvent? _userAccelerometerEvent;
  DateTime? _userAccelerometerUpdateTime;
  int? _userAccelerometerLastInterval;
  Duration sensorInterval = SensorInterval.normalInterval;

  final _streamSubscriptions = <StreamSubscription<dynamic>>[];

  double totalDistance = 0.0;
  bool distanceMode = false;

  String addDistance(bool stringMode) {
    double distX = 0;
    double distZ = 0;
    if (_userAccelerometerEvent?.x.abs() != null) {
      if (_userAccelerometerEvent!.x.abs() > 1) distX = _userAccelerometerEvent!.x.abs();
      if (_userAccelerometerEvent!.z.abs() > 1) distZ = _userAccelerometerEvent!.z.abs();
      double addDistance = sqrt(pow(distX, 2) + pow(distZ, 2));
      double speed = addDistance / 1000;
      totalDistance += speed;
      if (stringMode) return (totalDistance * 1000).toStringAsFixed(1);
      return totalDistance.toStringAsFixed(1);
    }
    return '0.0';
  }

  String distanceModeCheck() {
    if (distanceMode) return "${addDistance(distanceMode)} m";
    return "${addDistance(distanceMode)} km";
  }

  Future<void> _loadDistancePref() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() => distanceMode = prefs.getBool("distanceMode") ?? false);
  }

  Future<void> _saveDistancePref() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("distanceMode", distanceMode);
  }

  void ddCBDistanceMode(bool? selectedValue) {
    if (selectedValue is bool) {
      setState(() {
        distanceMode = selectedValue;
        _saveDistancePref();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadDistancePref();
    _streamSubscriptions.add(
      userAccelerometerEventStream(samplingPeriod: sensorInterval).listen(
        (UserAccelerometerEvent event) {
          final now = event.timestamp;
          setState(() {
            _userAccelerometerEvent = event;
            if (_userAccelerometerUpdateTime != null) {
              final interval = now.difference(_userAccelerometerUpdateTime!);
              if (interval > _ignoreDuration) {
                _userAccelerometerLastInterval = interval.inMilliseconds;
              }
            }
          });
          _userAccelerometerUpdateTime = now;
        },
        onError: (e) {
          showDialog(
            context: context,
            builder: (context) {
              return const AlertDialog(
                title: Text("Sensor Not Found"),
                content: Text("It seems that your device doesn't support User Accelerometer Sensor"),
              );
            }
          );
        },
        cancelOnError: true,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    for (final subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 50,),
                Container(
                  width: 250, height: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.white, width: 3)
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(
                      File(p.myProfile.getMyVehicles[widget.i].getImgPath),
                      fit: BoxFit.cover,
                      
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Text("Seguimiento al vehículo"),
                textTrackingMain(p.myProfile.getMyVehicles[widget.i].getModelo),
                Text("Distancia recorrida"),
                textTrackingMain(distanceModeCheck()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Usar Metros"),
                    SizedBox(width: 10,),
                    Switch(
                      value: distanceMode, 
                      onChanged: (value) => ddCBDistanceMode(value),
                    ),
                  ],
                ),
                Expanded(child: SizedBox()),
                TextButton(
                  child: Text("Volver",
                    style: TextStyle(
                      fontSize: 20
                    ),
                  ),
                  onPressed: () {
                    p.myProfile.addKM(widget.i, totalDistance);
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (BuildContext context) => DefaultTabController(length: 2, child: HomePage())),
                      (Route route) => false,
                    );
                  }, 
                ),
                
                SizedBox(height: 100,)
                // Text(p.myProfile.getMyVehicles[widget.i].imgPath.toString()),

              ],
            ),
          ),
        ),
      ),
    );
  }
}