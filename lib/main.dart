import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:proyecto_dispomoviles/classes/vehicle.dart' as vehicleList;
import 'package:proyecto_dispomoviles/classes/profile.dart' as profile;
import 'package:proyecto_dispomoviles/pages/home_page.dart';
import 'package:proyecto_dispomoviles/sharedPreferences.dart';
import 'package:proyecto_dispomoviles/widgets/themes.dart';



void main() async {

  // Forzar Orientación
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Caregistry',
      theme: profile.myProfile.getThemeData(profile.myProfile.getTema),
      home: DefaultTabController(length: 2, child: HomePage()),
    );
  }
}

ThemeData getThemeData(int theme) {

  vehicleList.generateVehicleList();

  switch(theme) {
    case 1: return blueAppTheme(); 
    case 2: return redAppTheme();
  }

  return defaultAppTheme(); 
}

