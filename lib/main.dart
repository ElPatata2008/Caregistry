import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:path/path.dart';
import 'package:proyecto_dispomoviles/entity/vehicle.dart' as vehicleList;
import 'package:proyecto_dispomoviles/entity/profile.dart' as profile;
import 'package:proyecto_dispomoviles/pages/home_page.dart';
import 'package:proyecto_dispomoviles/providers/theme.dart';
import 'package:proyecto_dispomoviles/providers/util.dart';
import 'package:proyecto_dispomoviles/widgets/themes.dart';
import 'package:sqflite/sqflite.dart';



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

    TextTheme textTheme = createTextTheme(context, "Aldrich", "Agdasima");
    MaterialTheme theme = MaterialTheme(textTheme);

    vehicleList.generateVehicleList();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Caregistry',
      theme: theme.dark(),
      home: DefaultTabController(length: 2, child: HomePage()),
    );
  }
}